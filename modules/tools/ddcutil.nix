{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.ddcutil;
in
{
  # Options
  options.modules.ddcutil.enable = mkEnableOption "ddcutil";

  # Config
  config = mkIf cfg.enable {

    # Enable i2c support
    hardware.i2c.enable = true;
    # Allow user i2c control
    users.users.${user}.extraGroups = [ "i2c" ];
    environment.systemPackages = with pkgs; [
      ddcutil # CLI
      ddcui   # GUI
    ];

  };
}
