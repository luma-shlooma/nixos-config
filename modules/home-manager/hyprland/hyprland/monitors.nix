args @ { pkgs, ... }:

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
  # Script to make and action selection
  reconfigure = pkgs.writeShellScriptBin "monitors" ''
    #!/usr/bin/env bash
    set -e

    # Options available
    monitor="Monitor"
    tv="TV"
    extend="Extend"
    mirror="Mirror"
    OPTIONS="$monitor
    $tv
    $extend
    $mirror"

    CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -lines 4 -p "Select Monitor Configuration")
    case "$CHOSEN" in
      "$monitor")
        hyprctl -r keyword monitor "${(enable monitors.main)}"
        hyprctl -r keyword monitor "${(disable monitors.tv)}"
        ;;
      "$tv")
        hyprctl -r keyword monitor "${(disable monitors.main)}"
        hyprctl -r keyword monitor "${(enable monitors.tv)}"
        ;;
      "$extend")
        hyprctl -r keyword monitor "${(enable monitors.main)}"
        hyprctl -r keyword monitor "${(enable monitors.tv)}"
        ;;
      "$mirror")
        hyprctl -r keyword monitor "${(enable monitors.main)}"
        hyprctl -r keyword monitor "${(mirror monitors.tv monitors.main.id)}"
        ;;
    esac
  '';
in
{
  # Make sure this is being used with the "home" host - because of hardcoded monitors
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/monitors";}//args);
  in
  [
    (assertLib.host "home")
    (assertLib.enabled "wayland.windowManager.hyprland.enable")
  ];

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
}
