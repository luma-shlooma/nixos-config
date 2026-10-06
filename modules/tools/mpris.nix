{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # This module's config options
  cfg = config.modules.mpris;
in
{
  # Options
  options.modules.mpris.enable = mkEnableOption "MPRIS";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Enable mpris service
      # Allows for media controls from bluetooth
      services.mpris-proxy.enable = true;

    };

  };
}
