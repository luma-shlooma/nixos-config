{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.docker;
in
{
  # Options
  options.modules.docker.enable = mkEnableOption "Docker";

  # Config
  config = mkIf cfg.enable {

    # Enable docker
    virtualisation.docker.enable = true;
    # Install docker-compose
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

  };
}
