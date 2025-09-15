# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
  rgb = code: "rgb("+code+")";
  # rgba = code: alpha: "rgba("+code+alpha+")";
in
lib.mkIf (config.theme.name == "alpha")
{
  programs.hyprlock.settings = {
    animations = {
      # Custom curves
      bezier = [
        "linear, 1, 1, 0, 0"
        "easein, 0, 0, 1, 0"
        "easeout, 0, 0, 0, 1"
      ];
      # Set animations
      animation = [
        # Fade in and out
        "fade, 1, 2, linear"
        "inputFieldColors, 1, 4, easeout"
        "inputFieldFade 1, 8, easein"
        "inputFieldDots 1, 2, linear"
      ];
    };
    background = [{
      color = rgb colours.true-black;
    }];
    input-field = [{
      size = "12%, 3%";
      outline_thickness = 3;
      dots_size = "0.2";
      dots_center = true;
      outer_color = rgb colours.white;
      inner_color = rgb colours.dark-black;
      font_color = rgb colours.white;
      font_family = "JetBrains Mono";
      fade_on_empty = true;
      fade_timeout = 5000;
      placeholder_text = "";
      check_color = rgb colours.magenta;
      fail_color = rgb colours.red;
      fail_text = "¯\\_(ツ)_/¯";
      position = "0, -40%";
    }];
    label = [{
      text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
      color = rgb colours.white;
      font_size = 64;
      font_family = "JetBrains Mono Extrabold";
      position = "0, -34%";
    }];
  };
}
