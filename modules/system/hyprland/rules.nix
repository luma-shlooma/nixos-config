{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {
    
    # The home-manager config
    home-manager.users.${user} = {

      # Set window rules
      wayland.windowManager.hyprland.settings.window_rule = [
        # Terminal
        { match.class = config.modules.terminal.app.selected;
          fullscreen = false;
        }
        # PiP
        { match.title = "Picture-in-Picture";
          # Static
          content = "video";
          float = true;
          pin = true;
          size = "monitor_w*0.25 monitor_h*0.25";
          move = "monitor_w-window_w-20 monitor_h*0.5";
          # Dynamic
          keep_aspect_ratio = true;
          border_size = 0;
          no_follow_mouse = true;
        }
        ## Steam
        { match.class = "steam_app_.+";
          # Static
          content = "game";
          fullscreen = true;
          # Dynamic
          # stay_focused = true;
        }
      ];

    };

  };
}
