{ ... }:

{
  # A prefered profile of hyprland-centric configuration
  imports = builtins.map import [
    # Basic hyprland
    ./hyprland

    # Launcher
    ./rofi
    # ./hyprshell

    # Lockscreen
    ./hyprlock

    # Status panel
    ./hyprpanel
    # ./waybar
  ];
}
