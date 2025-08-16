{ pkgs, config, ... }:

let
  # Colour scheme
  palette = import ./colours.nix;
in
{

  # rofi launcher
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";

    # Theming
    font = "JetBrains Mono";
    location = "center";
    theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # Theme adapted from: https://github.com/newmanls/rofi-themes-collection/blob/master/themes/squared-nord.rasi
      "*" = {
        font = "FiraCode Nerd Font Medium 12";
        bg0 = mkLiteral "#${palette.black}";
        bg1 = mkLiteral "#${palette.light.black}";
        fg0 = mkLiteral "#${palette.white}";
        accent-color = mkLiteral "#${palette.blue}";
        urgent-color = mkLiteral "#${palette.yellow}";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        margin = 0;
        padding = 0;
        spacing = 0;
      };
      "window" = {
        location = mkLiteral "center";
        width = 480;
        background-color = mkLiteral "@bg0";
      };
      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };
      "prompt, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };
      "prompt" = {
        text-color = mkLiteral "@accent-color";
      };
      "textbox" = {
        padding = mkLiteral "8px";
        background-color = mkLiteral "@bg1";
      };
      "listview" = {
        padding = mkLiteral "4px 0";
        lines = 8;
        columns = 1;
        fixed-height = false;
      };
      "element" = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "8px";
      };
      "element normal normal" = {
        text-color = mkLiteral "@fg0";
      };
      "element normal urgent" = {
        text-color = mkLiteral "@accent-color";
      };
      "element normal active" = {
        text-color = mkLiteral "@accent-color";
      };
      "element alternate active" = {
        text-color = mkLiteral "@accent-color";
      };
      "element selected" = {
        text-color = mkLiteral "@bg0";
      };
      "element selected normal, element selected active" = {
        background-color = mkLiteral "@accent-color";
      };
      "element selected urgent" = {
        background-color = mkLiteral "@urgent-color";
      };
      "element-icon" = {
        size = mkLiteral "0.8em";
      };
      "element-text" = {
        text-color = mkLiteral "inherit";
      };
    };
  };
  
  # Force focus on it - stray mouse movements wont unfocus it
  wayland.windowManager.hyprland.settings = {
    "windowrule" = [
      "stayfocused, class:(?i)^rofi$"
    ];
  };
}
