{ config, inputs, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Home directory
  home = config.settings.system.homeDir;
  # This module's config options
  cfg = config.modules.homeManager;
in
{
  # Options
  options.modules.homeManager.enable = mkEnableOption "Home Manager";

  # Import home-manager
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # Config
  config = mkIf cfg.enable {

    # Uses XDG
    modules.xdg.enable = true;

    # Home Manager
    home-manager = {
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit host inputs; };
      # Import the host-specific base home-manager config
      users.${user} = {

        # Import the host configuration
        imports = [
          ../../host/home-manager.nix
        ];

        # Common config

        home.username = "${user}";
        home.homeDirectory = "${home}";
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        # Add nixos config scripts to session path
        home.sessionPath = [
          "/etc/nixos/scripts/"
        ];

        # Unfree software
        # For Home-Manager programs
        nixpkgs.config.allowUnfree = true;
        # Catch for manual `nix-shell` installation
        home.sessionVariables = {
          NIXPKGS_ALLOW_UNFREE = 1;
        };

        # Enable XDG
        xdg = {
          enable = true;
          mimeApps.enable = true;
          configFile."mimeapps.list".force = true;
        };

      };
    };

  };
}
