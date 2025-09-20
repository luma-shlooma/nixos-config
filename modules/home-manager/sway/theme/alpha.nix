# Controlled Theme
{ pkgs, config, lib, ... }:

let
  colours = config.theme.colours;
  hex = code: "#${code}";
in
lib.mkIf (config.theme.name == "alpha")
{
  # Set swaylock theme option
  theme.modules.swaylock.options = "--screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ${colours.dark-white} --key-hl-color ${colours.dark-white} --line-color ${colours.dark-black} --inside-color ${colours.grey}88 --text-color ${colours.white} --separator-color ${colours.dark-black} --ring-ver-color ${colours.dark-white} --inside-ver-color ${colours.grey}88 --text-ver-color ${colours.white}";

  # Status bar colours
  programs.i3status = {
    general = {
      colors = true;
      color_good     = hex colours.green;
      color_degraded = hex colours.yellow;
      color_bad      = hex colours.red;
    };
  };

  # Yet to customise wofi
  programs.wofi = {
    settings = {
      prompt = "Launch: ";
    };
  };

  # Sway colours
  wayland.windowManager.sway = {
    config = {
      colors = {
        # Greyscale focused
        focused = {
          background  = hex colours.light-grey;
          border      = hex colours.dark-white;
          childBorder = hex colours.light-grey;
          indicator   = hex colours.dark-white;
          text        = hex colours.light-white;
        };
        # Orangey urgent
        urgent = {
          background  = hex colours.yellow;
          border      = hex colours.dark-yellow;
          childBorder = hex colours.yellow;
          indicator   = hex colours.dark-yellow;
          text        = hex colours.dark-white;
        };
        # Darker focused inactive
        focusedInactive = {
          background  = hex colours.light-black;
          border      = hex colours.dark-grey;
          childBorder = hex colours.light-black;
          indicator   = hex colours.grey;
          text        = hex colours.dark-white;
        };
        # Dark unfocused
        unfocused = {
          background  = hex colours.black;
          border      = hex colours.light-black;
          childBorder = hex colours.black;
          indicator   = hex colours.light-black;
          text        = hex colours.dark-white;
        };
      };
      # Sway Bar
      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            # Status
            background = hex colours.black;
            statusline = hex colours.white;
            separator  = hex colours.light-grey;
            # WS
            focusedWorkspace = {
              background = hex colours.blue;
              border     = hex colours.dark-blue;
              text       = hex colours.black;
            };
            urgentWorkspace = {
              background = hex colours.magenta;
              border     = hex colours.dark-magenta;
              text       = hex colours.black;
            };
            inactiveWorkspace = {
              background = hex colours.light-black;
              border     = hex colours.dark-grey;
              text       = hex colours.dark-white;
            };
          };
        }
      ];
    };
    # Extra - black background
    extraConfig = ''
      output * bg ${hex colours.dark-black} solid_color
    '';
  };  
}
