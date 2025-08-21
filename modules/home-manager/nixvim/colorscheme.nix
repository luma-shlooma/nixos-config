# At some point need to unify colour asset access...
let
  palette = import ../../../assets/colours.nix;
in
{
  programs.nixvim = {
    colorschemes = {
      base16 = {
        enable = true;
        colorscheme = {
          # See https://github.com/chriskempson/base16/blob/main/styling.md ()
          base00 = "#${palette.black}";
          base01 = "#${palette.light.black}";
          base02 = "#${palette.light.black}";
          base03 = "#${palette.dark.grey}";
          base04 = "#${palette.grey}";
          base05 = "#${palette.white}";
          base06 = "#${palette.light.white}";
          base07 = "#${palette.dark.grey}";
          base08 = "#${palette.light.red}";
          base09 = "#${palette.dark.yellow}";
          base0A = "#${palette.yellow}";
          base0B = "#${palette.green}";
          base0C = "#${palette.cyan}";
          base0D = "#${palette.blue}";
          base0E = "#${palette.magenta}";
          base0F = "#${palette.light.blue}";
        };
      };
    };
    opts.termguicolors = true;
  };
}
