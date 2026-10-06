{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.wine;
in
{
  # Options
  options.modules.wine.enable = mkEnableOption "Wine";

  # Config
  config = mkIf cfg.enable {

    # Some wine programs for various use
    environment.systemPackages = with pkgs; [
      wine-wayland
      winetricks
      bottles
    ];

  };
}
