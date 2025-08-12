{ ... }:

{
  imports = [
    # 
    ./general.nix
    ./bindings.nix
    ./cursor.nix
    ./theme.nix
    ./monitors.nix
    ./rofi.nix
    ./hyprlock.nix
    ./waybar.nix
    ./dunst.nix
  ];

  wayland.windowManager.hyprland.enable = true;
}
