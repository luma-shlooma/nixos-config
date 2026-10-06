{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.discord;
in
{
  # Options
  options.modules.discord.enable = mkEnableOption "Discord";

  # Config
  config = mkIf cfg.enable {

    # Install package
    environment.systemPackages = with pkgs; [
      discord
    ];

  };
}
