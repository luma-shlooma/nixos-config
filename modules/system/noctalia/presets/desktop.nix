{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Form factor of host
  form = config.settings.hardware.form;
  # Home Assistant module
  ha = config.modules.homeAssistant;
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
            end = (optionals ha.enable [ "pozzoo/hassio:status" ]) ++ [ "audio_visualizer" "big-gap" "clock" "clipboard" "notifications" ];
          };
        };

        # https://docs.noctalia.dev/noctalia/configuration/shell/#osd
        osd = {
          position = "top_center";
          position_vertical = "center_right";
          orientation = "vertical";
        };

      } ++ optionalAttrs ha.enable {

        # https://docs.noctalia.dev/noctalia/plugins/
        plugins.enabled = [
          "pozzoo/hassio" # Home Assistant widgets
        ];

      };

    };
  };
}
