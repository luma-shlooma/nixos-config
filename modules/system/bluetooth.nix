{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.buetooth;
in
{
  # Options
  options.modules.buetooth.enable = mkEnableOption "Bluetooth";

  # Config
  config = mkIf cfg.enable {

    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    # Bluetooth tui
    environment.systemPackages = with pkgs; [ bluetuith ];

  };
}
