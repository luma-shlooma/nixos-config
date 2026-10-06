{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.easyeffects;
in
{
  # Options
  options.modules.easyeffects.enable = mkEnableOption "Easy Effects";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Enable easyeffects
      services.easyeffects = {
        enable = true;
        # TODO: Presets, or nah?
      };

    };

    # Requires dconf
    programs.dconf.enable = true;

  };
}
