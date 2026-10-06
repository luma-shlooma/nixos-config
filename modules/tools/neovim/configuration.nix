{ config, inputs, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.neovim;
in
{
  # Options
  options.modules.neovim = {
    enable = mkEnableOption "Neovim";
  };

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      imports = [
        inputs.nixvim.homeModules.nixvim
      ];

      # Enable nixvim and import all sibling files
      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        imports = [
          # Config
          ./autocommands.nix
          ./keybinds.nix
          ./options.nix
          # Plugins
          ./plugins/autopairs.nix
          ./plugins/blink/default.nix
          ./plugins/colorful-menu.nix
          ./plugins/icons.nix
          ./plugins/lsp.nix
          ./plugins/surround.nix
          ./plugins/telescope.nix
          ./plugins/treesitter.nix
          ./plugins/yazi.nix
        ];
      };

    };

  };
}
