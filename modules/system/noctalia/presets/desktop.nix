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
            end = [ "audio_visualizer" "big-gap" ] ++ (optionals ha.enable [ "pozzoo/hassio:status" ]) ++ [ "clock" "clipboard" "notifications" ];
          };
        };

        # https://docs.noctalia.dev/noctalia/control-center/shortcuts/
        control_center.shortcuts = [
          "wifi" "bluetooth"
        ] ++ (optionals ha.enable [
          "pozzoo/hassio:ha_toggle_1" "pozzoo/hassio:ha_toggle_2"
        ]) ++ [
          "media"
        ];

        # https://docs.noctalia.dev/noctalia/configuration/shell/#osd
        osd = {
          position = "top_center";
          position_vertical = "center_right";
          orientation = "vertical";
        };

      } // optionalAttrs ha.enable {

        # https://docs.noctalia.dev/noctalia/plugins/
        plugins.enabled = [
          "pozzoo/hassio" # Home Assistant widgets+
        ];

        # https://noctalia.dev/plugins/community/hassio
        plugin_settings."pozzoo/hassio" = {
          ha_url = "${ha.server}";
          ha_token = "${ha.token}";
          shortcut_entity_1 = "switch.lamp";
          shortcut_entity_2 = "input_boolean.manual";
        };

      };

    };
  };
}
