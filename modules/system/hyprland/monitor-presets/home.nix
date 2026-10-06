{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  preset = config.settings.hardware.monitorPreset;
  kanshi = config.modules.kanshi;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland") && (preset == "home") && !kanshi.enable) {

    # Enable ddcutil (I forget exactly how this is used)
    modules.ddcutil.enable = true;

    # The home-manager config
    home-manager.users.${user} = 
    let
      # Monitor logic
      monitors = {
        main = {
          id = "DP-1";
          mode = "highrr";
          pos = "auto-center-left";
        };
        tv = {
          id = "HDMI-A-1";
          mode = "highres";
          pos = "auto-center-right";
        };
      };
      # Funcs turn monitor descriptions to hyprland assignment values
      enable  = {id, mode, pos}: "${id}, ${mode}, ${pos}, 1";
      disable = {id, mode, pos}: "${id}, disable";
      mirror  = monitor: mirror_id: "${(enable monitor)}, mirror, ${mirror_id}";
      # Options available to select from
      op_monitor = "Monitor";
      op_tv      = "TV";
      op_extend  = "Extend";
      op_mirror  = "Mirror";
      options = "${op_monitor}\n${op_tv}\n${op_extend}\n${op_mirror}";
      # Script to make and action selection
      reconfigure = pkgs.writeShellScriptBin "monitors" ''
        #!/usr/bin/env bash
        set -e

        CHOSEN=$(${config.settings.launcher.dmenu options "Select Monitor Configuration"})
        case "$CHOSEN" in
          "${op_monitor}")
            hyprctl -r keyword monitor "${(enable monitors.main)}"
            hyprctl -r keyword monitor "${(disable monitors.tv)}"
            ;;
          "${op_tv}")
            hyprctl -r keyword monitor "${(disable monitors.main)}"
            hyprctl -r keyword monitor "${(enable monitors.tv)}"
            ;;
          "${op_extend}")
            hyprctl -r keyword monitor "${(enable monitors.main)}"
            hyprctl -r keyword monitor "${(enable monitors.tv)}"
            ;;
          "${op_mirror}")
            hyprctl -r keyword monitor "${(enable monitors.main)}"
            hyprctl -r keyword monitor "${(mirror monitors.tv monitors.main.id)}"
            ;;
        esac
      '';
    in
    {

      # Add that script to home
      home.packages = [ reconfigure ];
      # Apply to hyprland
      wayland.windowManager.hyprland = {
        settings = {
          # Default setup
          monitor = [
            (enable monitors.main)
            (disable monitors.tv)
          ];
          bind = [
            "SUPER, p, exec, ${reconfigure}/bin/monitors"
          ];
        };
      };

    };

  };
}
