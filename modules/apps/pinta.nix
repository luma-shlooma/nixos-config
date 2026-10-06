{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.pinta;
in
{
  # Options
  options.modules.pinta.enable = mkEnableOption "Pinta";

  # Config
  config = mkIf cfg.enable {

    # Pinta image editing software
    environment.systemPackages = [
      pkgs.pinta
    ];

  };
}
