{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # This module's config options
  cfg = config.modules.noctalia;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.preset == "desktop")) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Then desktop preset overrides
      programs.noctalia.settings = {
        # https://docs.noctalia.dev/v5/bar/
        bar = {
          main = {
            position = "top";
            start = [ "session" "control-center" "small-gap" "network" "bluetooth" "volume" "big-gap" "media" ];
            center = [ "workspaces" ];
            end = [ "audio_visualizer" "big-gap" "clock" "clipboard" "notifications" ];
          };
        };

        # https://docs.noctalia.dev/v5/configuration/shell/#osd
        osd = {
          position = "center_right";
          orientation = "vertical";
        };
      };

    };
  };
}
