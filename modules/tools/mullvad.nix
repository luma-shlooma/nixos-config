{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.mullvad;
in
{
  # Options
  options.modules.mullvad.enable = mkEnableOption "Mullvad VPN";

  # Config
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      mullvad-vpn # Client
      mullvad     # CLI
    ];

    services.mullvad-vpn.enable = true;

  };
}
