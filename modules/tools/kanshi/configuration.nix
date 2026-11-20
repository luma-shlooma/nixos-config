{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.kanshi;
  # Specific hardware device
  device = config.settings.hardware.device;
in
{
  # Options
  options.modules.kanshi = {
    enable = mkEnableOption "Kanshi";
    preset = mkOption {
      type = types.nullOr (types.enum [ "orion" ]);
      default = if (device == "thinkpad-t14") then "orion" else null;
      description = "Which kanshi settings preset to enable.";
    };
  };

  # Config
  config = mkIf cfg.enable {

    # Start kanshi
    settings.windowManager.onStartUp = [ "kanshi" ];

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Enable kanshi
      services.kanshi.enable = true;

    };

  };
}
