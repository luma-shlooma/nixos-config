# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
  # Launch a cli tool
  cli-popup = executable: "hyprctl dispatch exec '[float; pin; stayfocused; size 50% 50%] alacritty -e "+executable+"'";
in
lib.mkIf (config.theme.name == "alpha")
{
  # Settings for the waybar bar
  programs.waybar = {
    settings = {
      # Describe contents of bar
      bar = {
        position = "top";
        height = 24;
        spacing = 6;
        modules-left = [
          "privacy"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "memory"
          "cpu"
          "network"
        ];

        # Module config
        "privacy" = {
          icon-spacing = 4;
          icon-size = 16;
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
          on-click-right = cli-popup "bluetuith";
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
    # CSS Styling
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrains Mono;
        color: #${colours.white};
      }
      window#waybar {
        background: #${colours.black};
        border-bottom: 3px solid #${colours.grey};
      }
      tooltip {
        background: #${colours.black};
        border: 1px solid #${colours.grey};
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
        color: #${colours.white};
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
        background-color: #${colours.yellow};
      }
      #clock {
        background-color: #${colours.grey};
      }
      #pulseaudio {
        background-color: #${colours.yellow};
        color: #${colours.black};
      }
      #memory {
        background-color: #${colours.red};
        color: #${colours.black};
      }
      #cpu {
        background-color: #${colours.magenta};
        color: #${colours.black};
      }
      #network {
        padding-left: 8px;
        background-color: #${colours.blue};
        color: #${colours.black};
      }
    '';
  };
}
