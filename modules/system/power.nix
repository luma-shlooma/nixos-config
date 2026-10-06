{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.power;
in
{
  # Options
  options.modules.power.enable = mkEnableOption "Power Management";

  # Config
  config = mkIf cfg.enable {

    # The following were originally required by noctalia

    # Allow power management support in apps
    services.upower.enable = true;
    # Allow system changes based on configured power profiles
    services.power-profiles-daemon.enable = true;

  };
}
