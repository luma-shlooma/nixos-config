{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.libreoffice;
in
{
  # Options
  options.modules.libreoffice.enable = mkEnableOption "Libreoffice";

  # Config
  config = mkIf cfg.enable {

    # Install libreoffice
    environment.systemPackages = [
      pkgs.libreoffice
    ];

  };
}
