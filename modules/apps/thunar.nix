{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.thunar;
in
{
  # Options
  options.modules.thunar.enable = mkEnableOption "Thunar File Explorer";

  # Config
  config = mkIf cfg.enable {

    # Thunar file explorer
    environment.systemPackages = with pkgs; [
      thunar
    ];

  };
}
