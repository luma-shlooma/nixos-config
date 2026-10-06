{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.audacity;
in
{
  # Options
  options.modules.audacity.enable = mkEnableOption "Audacity";

  # Config
  config = mkIf cfg.enable {

    # Install package
    environment.systemPackages = with pkgs; [
      audacity
    ];

  };
}
