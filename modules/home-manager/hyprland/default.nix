{ ... }:

{
  # A prefered profile of hyprland-centric configuration
  imports = builtins.map import [
    # Basic hyprland
    ./hyprland

    # Launcher
    # ./rofi
    ../walker
    # ./hyprshell

    # NOTE: The following are currently being implemented by noctalia
    ./start-noctalia.nix

    # Lockscreen
    # ./hyprlock

    # Status panel
    # ./hyprpanel
    # ./waybar
  ];
}
