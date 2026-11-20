{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Form factor of host
  form = config.settings.hardware.form;
  primary = config.settings.hardware.outputs.primary;
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
        bar =
          let
            # Config that may be applied to a specific output or globally
            config = {
              enabled = true;
              position = "bottom";
              start = [ "session" "control-center" "spacer" "network" "bluetooth" "volume" "brightness" ];
              center = [ "workspaces" ];
              end = [ "battery" "clock" ];
            };
          in {
          main = if (primary == null) then config else { monitors.${primary} = config; };
        };

        # https://docs.noctalia.dev/noctalia/configuration/shell/#osd
        osd = {
          position = "bottom_center";
          position_vertical = "center_right";
          orientation = "horizontal";
        };

      };

    };
  };
}
