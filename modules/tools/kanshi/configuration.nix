{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.kanshi;
in
{
  # Options
  options.modules.kanshi = {
    enable = mkEnableOption "Kanshi";
    preset = mkOption {
      type = types.nullOr (types.enum [ "orion" ]);
      default = null;
      description = "Which kanshi settings preset to enable. This will be hardware-dependant.";
    };
  };

  # Config
  config = mkIf cfg.enable {

    # Start kanshi
    settings.windowManager.onStartUp = [ "kanshi" ];

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Enable kanshi
      services.kanshi.enable = true;

    };

  };
}
