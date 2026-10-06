{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.vlc;
in
{
  # Options
  options.modules.vlc.enable = mkEnableOption "VLC";

  # Config
  config = mkIf cfg.enable {

    # Install VLC
    environment.systemPackages = with pkgs; [
      vlc
    ];

  };
}
