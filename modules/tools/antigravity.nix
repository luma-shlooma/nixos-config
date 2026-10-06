{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.antigravity;
in
{
  # Options
  options.modules.antigravity.enable = mkEnableOption "Antigravity CLI";

  # Config
  config = mkIf cfg.enable {

    # Install package
    environment.systemPackages = with pkgs; [
      antigravity-cli
    ];

  };
}
