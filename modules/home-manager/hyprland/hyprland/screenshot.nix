{ pkgs, ... }:

let
  # A load of bash with `grim`, `slurp`, `hyprpicker` & `libnotify`
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/usr/bin/env bash
    
    set -e

    # Ensure screenshot dir exists
    store_dir="$HOME/Pictures/Screenshots"
    mkdir -p "$store_dir"

    # Determine action
    action="$1"
    if [ -z "$action" ]; then
      echo "Usage: $0 {full|select|colour}"
      exit 1
    fi

    # Colour
    if [ "$action" = "colour" ]; then
      hyprpicker -an
      exit 0 # Exit early, no file or notify
    fi

    # Designate file
    file_path="$store_dir/screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"

    # Execute
    case "$action" in
      "full")
        grim "$file_path"
        ;;
      "select")
        grim -g "$(slurp)" "$file_path"
        ;;
    esac

    # Notify
    notify-send "Screenshot" "Screenshot has been saved." \
      -u normal \
      -t 30000 \
      -a "Grim" \
      -i screenshooter \
      --action="scriptAction:-xdg-open $store_dir=Directory" \
      --action="scriptAction:-xdg-open $file_path=View"
  '';
in
{
  # Add that script to home
  home.packages = [ screenshot ];
  # Add to keybinds
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, s, exec, ${screenshot}/bin/screenshot full"
    "SUPER_SHIFT, s, exec, ${screenshot}/bin/screenshot select"
    "SUPER_CTRL_SHIFT, s, exec, ${screenshot}/bin/screenshot colour"
  ];
}
