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
  config = mkIf (cfg.enable && (form == "laptop")) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Then laptop preset overrides
      programs.noctalia.settings = {
        # https://docs.noctalia.dev/noctalia/bar/
        bar = {
          main = {
            enabled = false;
            monitor.eDP-1 = {
              enabled = true;
              position = "bottom";
              start = [ "session" "control-center" "spacer" "network" "bluetooth" "volume" "brightness" ];
              center = [ "workspaces" ];
              end = [ "battery" "clock" ];
            };
          };
        };

        # https://docs.noctalia.dev/noctalia/configuration/shell/#osd
        osd = {
          position = "bottom_center";
          orientation = "horizontal";
        };
        
        # https://docs.noctalia.dev/noctalia/services/notifications/
        notification = {
          monitors = [ "eDP-1" ];
        };

        # https://docs.noctalia.dev/noctalia/configuration/shell/?section=lock-screen#lock-screen
        lockscreen = {
          monitors = [ "eDP-1" ];
        };
      };

    };
  };
}
