args @ { ... }:

{
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/hyprpanel";}//args);
  in
  [ (assertLib.enabled "wayland.windowManager.hyprland.enable") ];
  # TODO: Assert noctalia is configured

  # Start on launch
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "noctalia-shell"
    ];
  };
  
}
