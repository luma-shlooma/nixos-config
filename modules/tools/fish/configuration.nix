{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.fish;
  pkg = pkgs.fish;
in
{
  # Options
  options.modules.fish.enable = mkEnableOption "fish";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Fish
      programs.fish = {
        enable = true;
        package = pkg;
        interactiveShellInit = ''
          set fish_greeting
        '';
        };
        plugins = [
          { name = "z"; src = pkgs.fishPlugins.z.src; }
          { name = "done"; src = pkgs.fishPlugins.done.src; }
        ];
      };

    };

    # Set package if preferred
    settings.terminal.shell.package = mkIf (config.settings.terminal.shell.selected == "fish") pkg;

  };
}
