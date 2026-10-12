{ config, lib, pkgs, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Theme options
  theme = config.settings.theme.selected;
  colours = config.settings.theme.colours;
  hash = col: "#${col}";
  # This module's config options
  cfg = config.modules.kitty;
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # Uses custom font
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    # home-manager config theming
    home-manager.users.${user} = {

      # Kitty theming
      programs.kitty = {
        font = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
          size = 11;
        };
        settings = {
          # Colours
          color0 = hash colours.black;
          color1 = hash colours.red;
          color2 = hash colours.green;
          color3 = hash colours.yellow;
          color4 = hash colours.blue;
          color5 = hash colours.magenta;
          color6 = hash colours.cyan;
          color7 = hash colours.white;
          # Light
          color8  = hash colours.light-black;
          color9  = hash colours.light-red;
          color10 = hash colours.light-green;
          color11 = hash colours.light-yellow;
          color12 = hash colours.light-blue;
          color13 = hash colours.light-magenta;
          color14 = hash colours.light-cyan;
          color15 = hash colours.light-white;
          # Elements
          foreground = hash colours.white;
          background = hash colours.black;
          selection_foreground = "none";
          selection_background = "none";
          cursor = "none";
          text_composition_strategy = "1.7 0";
        };
      };

    };

    # nmtui uses newt which requires the following for colour
    environment.sessionVariables = {
      NEWT_COLORS = ''
        root=lightgray,black
        border=lightgray,black
        window=lightgray,black
        shadow=black,black
        title=green,black
        button=lightgray,black
        actbutton=black,green
        checkbox=lightgray,black
        actcheckbox=black,green
        entry=lightgray,black
        label=lightgray,black
        listbox=lightgray,black
        actlistbox=lightgray,black
        textbox=gray,lightgray
        acttextbox=lightgray,gray
        helpline=lightgray,black
        roottext=gray,black
        emptyscale=,black
        fullscale=,black
        disentry=grey,black
        compactbutton=black,yellow
        sellistbox=lightgray,black
        actsellistbox=black,lightgray
      '';
    };


  };
}
