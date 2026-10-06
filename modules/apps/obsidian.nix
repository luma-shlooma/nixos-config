{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.obsidian;
in
{
  # Options
  options.modules.obsidian.enable = mkEnableOption "Obsidian";

  # Config
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      obsidian
    ];

  };
}
