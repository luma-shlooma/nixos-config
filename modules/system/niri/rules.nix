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
  config = mkIf (cfg.enable && (cfg.selected == "niri")) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # All window rules
      programs.niri.settings.window-rules = [
        {
          # Increase kitty terminal width
          matches = [ { app-id = "kitty"; } ];
          default-column-width.fixed = 800;
        }
      ];

    };

  };
}
