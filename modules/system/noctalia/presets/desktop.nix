{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Form factor of host
  form = config.settings.hardware.form;
  # This module's config options
  cfg = config.modules.noctalia;
in
{
  # Config
  config = mkIf (cfg.enable && (form == "desktop")) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Then desktop preset overrides
      programs.noctalia.settings = {
        # https://docs.noctalia.dev/noctalia/bar/
        bar = {
          main = {
            position = "top";
            start = [ "session" "control-center" "small-gap" "network" "bluetooth" "volume" "big-gap" "media" ];
            center = [ "workspaces" ];
            end = [ "audio_visualizer" "big-gap" "clock" "clipboard" "notifications" ];
          };
        };

        # https://docs.noctalia.dev/noctalia/configuration/shell/#osd
        osd = {
          position = "center_right";
          orientation = "vertical";
        };
      };

    };
  };
}
