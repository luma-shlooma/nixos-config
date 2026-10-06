{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "niri")) {

    # The home-manager config
    home-manager.users."${user}" = {

      # Map start-up commands to format
      programs.niri.settings.spawn-at-startup = 
        builtins.map (cmd: {argv=[cmd];}) cfg.onStartUp;

    };

  };
}
