{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.obs;
in
{
  # Options
  options.modules.obs.enable = mkEnableOption "OBS";

  # Config
  config = mkIf cfg.enable {

    # Enable OBS
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };

  };
}
