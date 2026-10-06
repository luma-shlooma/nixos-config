{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.amazon-q;
in
{
  # Options
  options.modules.amazon-q.enable = mkEnableOption "Amazon Q";

  # Config
  config = mkIf cfg.enable {

    # Install package
    environment.systemPackages = with pkgs; [
      amazon-q-cli
    ];

  };
}
