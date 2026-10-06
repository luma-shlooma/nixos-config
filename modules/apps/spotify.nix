{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.spotify;
in
{
  # Options
  options.modules.spotify.enable = mkEnableOption "Spotify";

  # Config
  config = mkIf cfg.enable {

    # Spotify
    environment.systemPackages = with pkgs; [
      spotify
    ];

  };
}
