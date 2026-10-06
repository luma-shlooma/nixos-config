{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.wootility;
in
{
  # Options
  options.modules.wootility.enable = mkEnableOption "Wootility";

  # Config
  config = mkIf cfg.enable {

    # Install the wootility app
    environment.systemPackages = with pkgs; [
      wootility
    ];
    
    # Enable required wooting udev rules
    hardware.wooting.enable = true;

  };
}
