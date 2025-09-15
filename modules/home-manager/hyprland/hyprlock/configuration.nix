args @ { ... }:

{
  # Can only be used in conjunction with hyprland
  assertions = 
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/hyprlock";}//args);
  in
  [ (assertLib.enabled "wayland.windowManager.hyprland.enable") ];

  # Lockscreen
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        fail_timeout = 1000;
      };
    };
  };

  # Add to keybinds
  wayland.windowManager.hyprland.settings.bind = [
    # Lockscreen on SUPER + `
    "SUPER, code:49, exec, hyprlock"
  ];
}
