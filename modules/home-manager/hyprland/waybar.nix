{ ... }:

let
  # Colours
  palette = import ./colours.nix;
  # Launch a cli tool
  cli-popup = executable: "hyprctl dispatch exec '[float; pin; stayfocused; size 50% 50%] alacritty -e "+executable+"'";
in
{
  # Waybar status bar
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        output = [ "DP-1" ];
        position = "top";
        height = 24;
        spacing = 6;


        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
          "privacy"
        ];
        modules-right = [
          "pulseaudio"
          "memory"
          "cpu"
          "network"
        ];

        # Module config

        "hyprland/workspaces" = {
          active-only = false;
          format = "{id}";
          format-icons = {
            "default" = "";
            "active" = "";
          };
          # TODO: in the css, find way to change mouse hover effect
        };

        "clock" = {
          tooltip = false;
        };

        "privacy" = {
          icon-spacing = 4;
          icon-size = 20;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = false;
            }
            {
              type = "audio-in";
              tooltip = false;
            }
          ];
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-bluetooth = "󰂯{icon}  {volume}%";
          format-icons = {
            default = "";
            headphone = "";
            headset = "";
            speaker = "󰜟";
            # Special case for pc mic
            alsa_output.usb-31b2_FDUCE_SL40_Audio_Device_0000KT3a190000019-00.analog-stereo = "";
          };
          scroll-step = "2.0";
          max-volume = 100;
          on-click = cli-popup "pulsemixer";
        };

        "memory" = {
          format = "  {percentage}%";
          on-click = "alacritty -e htop";
          tooltip = true;
          tooltip-format = "{used}GB used";
        };

        "cpu" = {
          format = "{icon}  {usage}%";
          format-icons = [ "" ];
          on-click = "alacritty -e htop";
          tooltip = true;
          tooltip-format = "{load}";
        };

        "network" = {
          # Display icon
          format = "{icon} ";
          format-icons = {
            disabled = "󱚼";
            disconnected = "󰖪";
            linked = "";
            ethernet = "";
            wifi = "󰖩";
          };
          # Addition wifi info on tooltip
          tooltip-format-wifi = "{essid} {frequency}GHz ({signalStrength}%)";
          # nmtui on click
          on-click = cli-popup "nmtui";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrains Mono;
        color: #${palette.white};
      }

      window#waybar {
        background: #${palette.black};
        border-bottom: 3px solid #${palette.grey};
      }

      tooltip {
        background: #${palette.black};
        border: 1px solid #${palette.grey};
      }

      label.module {
        padding-left: 4px;
        padding-right: 4px;
        margin-left: 2px;
        margin-right: 2px;
      }

      #workspaces button {
        font-family: "Cantarell";
        font-weight: bold;
        background-color: transparent;
        color: #${palette.white};
        box-shadow: none;
        text-shadow: none;
        padding: 0px;
        border-radius: 0;
        padding-left: 5px;
        padding-right: 2px;
      }
      #workspaces .workspace-label {
        padding-left: 3px;
        border-top: 1px solid transparent;
      }
      #workspaces button.urgent {
        background-color: #${palette.yellow};
      }


      #clock {
        background-color: #${palette.grey};
      }

      #pulseaudio {
        background-color: #${palette.yellow};
        color: #${palette.black};
      }

      #memory {
        background-color: #${palette.red};
        color: #${palette.black};
      }

      #cpu {
        background-color: #${palette.magenta};
        color: #${palette.black};
      }

      #network {
        padding-left: 8px;
        background-color: #${palette.blue};
        color: #${palette.black};
      }
    '';
  };
  
  # Autostart
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar"
    ];
  };
}
