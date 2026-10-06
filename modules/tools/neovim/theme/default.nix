{ config, lib, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Theme options
  theme = config.settings.theme.selected;
  colours = config.settings.theme.colours;
  # This module's config options
  cfg = config.modules.neovim;
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users."${user}" = {

      # Theme nixvim
      programs.nixvim = {
        opts.termguicolors = true;
        colorschemes = {
          base16 = {
            enable = true;
            colorscheme = {
              # See https://github.com/chriskempson/base16/blob/main/styling.md ()
              base00 = "#${colours.black}";
              base01 = "#${colours.light-black}";
              base02 = "#${colours.light-black}";
              base03 = "#${colours.grey}";
              base04 = "#${colours.grey}";
              base05 = "#${colours.white}";
              base06 = "#${colours.light-white}";
              base07 = "#${colours.dark-grey}";
              base08 = "#${colours.blue}";
              base09 = "#${colours.dark-yellow}";
              base0A = "#${colours.yellow}";
              base0B = "#${colours.green}";
              base0C = "#${colours.cyan}";
              base0D = "#${colours.light-red}";
              base0E = "#${colours.magenta}";
              base0F = "#${colours.light-red}";
            };
          };
          # oxocarbon.enable = true;
        };
      };

    };

  };
}
