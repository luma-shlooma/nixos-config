# THIS IS UNUSED IN PREFERENCE TO HYPRPANEL
# THEME STILL NEEDS TO BE SEGREGATED
{ pkgs, ... }:

{
  # UNFINISHED
  assertions =
  let
    assetLib = pkgs.callPackage ../../../../lib/assertions {module = "hyprland/waybar";};
  in
  [ assetLib.unfinished ];

  # Import dunst config
  imports = [
    ./dunst.nix
  ];

  # Waybar status bar
  programs.waybar = {
    enable = true;
    settings.bar = {
      layer = "top";
      output = [ "DP-1" ];
    };
  };
  
  # Autostart
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "waybar"
    ];
  };
}
