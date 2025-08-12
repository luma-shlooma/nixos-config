{ ... }:

let
  # Colour scheme
  palette = import ./colours.nix;
  rgb = palette.rgb;
in
{
  # Lockscreen
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        fail_timeout = 1000;
      };

      # Theme & Design

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

      background = [
        {
          color = palette.rgb palette.true-black;
        }
      ];

      input-field = [
        {
          size = "12%, 3%";
          outline_thickness = 3;
          dots_size = "0.2";
          dots_center = true;
          outer_color = rgb palette.white;
          inner_color = rgb palette.dark.black;
          font_color = rgb palette.white;
          font_family = "JetBrains Mono";
          fade_on_empty = true;
          fade_timeout = 5000;
          placeholder_text = "";
          check_color = rgb palette.magenta;
          fail_color = rgb palette.red;
          fail_text = "¯\\_(ツ)_/¯";
          position = "0, -40%";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = rgb palette.white;
          font_size = 64;
          font_family = "JetBrains Mono Extrabold";
          position = "0, -34%";
        }
      ];
    };
  };
}
