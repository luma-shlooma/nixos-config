{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        ## Video
        "match:title Picture-in-Picture, content video"
        
        # PiP
        "match:title Picture-in-Picture, tag +pip"
        # Static
        "match:title Picture-in-Picture, float on"
        "match:title Picture-in-Picture, size 25% 25%"
        "match:title Picture-in-Picture, move 100%-w-20 50%"
        "match:title Picture-in-Picture, pin on"
        # Dynamic
        "match:tag pip, keep_aspect_ratio on"
        "match:tag pin, border_size 0"
        "match:tag pin, no_follow_mouse on"

        ## Games
        "match:class steam_app_.+, content game"

        # Steam
        "match:class steam_app_.+, tag +game"
        # Static
        "match:class steam_app_.+, fullscreen on"
        # Dynamic
        "match:class steam_app_.+, stay_focused on"
      ];
    };
  };
}
