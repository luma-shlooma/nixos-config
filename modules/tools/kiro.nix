{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.kiro;
in
{
  # Options
  options.modules.kiro.enable = mkEnableOption "Kiro CLI";

  # Config
  config = mkIf cfg.enable {

    # Install package
    environment.systemPackages = with pkgs; [
      kiro-cli
    ];

  };
}
