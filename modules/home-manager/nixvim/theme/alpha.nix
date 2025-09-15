# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
in
lib.mkIf (config.theme.name == "alpha")
{
  programs.nixvim = {
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
    };
    opts.termguicolors = true;
  };
}
