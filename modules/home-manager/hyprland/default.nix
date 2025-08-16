{ ... }:

{
  imports = [
    # 
    ./general.nix
    ./bindings.nix
    ./cursor.nix
    ./theme.nix
    ./monitors.nix
    # ./hyprshell.nix
    # Alternative to hyprshell
    ./rofi.nix
    ./hyprlock.nix
    ./hyprpanel.nix
    # Alternative to hyprpanel
    # ./waybar.nix
    # ./dunst.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}
