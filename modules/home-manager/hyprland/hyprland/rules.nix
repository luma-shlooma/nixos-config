{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        ## Video
        "content video, title:Picture-in-Picture"
        
        # PiP
        "tag +pip, title:Picture-in-Picture"
        # Static
        "float, title:Picture-in-Picture"
        "size 25% 25%, title:Picture-in-Picture"
        "move 100%-w-20 50%, title:Picture-in-Picture"
        "pin, title:Picture-in-Picture"
        # Dynamic
        "keepaspectratio, tag:pip"
        "noborder, tag:pip"
        "nofollowmouse, tag:pip"

        ## Games
        "content game, class:steam_app_.+"

        # Steam
        "tag +game, class:steam_app_.+"
        # Static
        "fullscreen, class:steam_app_.+"
        "stayfocused, class:steam_app_.+"
      ];
    };
  };
}
