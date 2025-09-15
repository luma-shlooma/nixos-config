args @ { pkgs, ... }:

{
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/rofi";}//args);
  in
  [ (assertLib.enabled "wayland.windowManager.hyprland.enable") ];

  # rofi launcher
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
  
  wayland.windowManager.hyprland.settings = {
    # Force focus on it - stray mouse movements wont unfocus it
    "windowrule" = [
      "stayfocused, class:(?i)^rofi$"
    ];
    # Set keybind
    bind = [
      "SUPER, d, exec, rofi -show drun -show-icons"
    ];
  };
}
