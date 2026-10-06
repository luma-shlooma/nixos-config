{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.wireguard;
in
{
  # Options
  options.modules.wireguard.enable = mkEnableOption "Wireguard";

  # Config
  config = mkIf cfg.enable {

    # TODO: Standardise inter-module relations
    config.modules.network.enable = true;

    # wg-tools
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
    
    # Allow wireguard connections through firewall
    networking.firewall.checkReversePath = "loose";

    # Setup using https://joshbuker.com/blog/how-to-use-wireguard-on-nixos-with-gnome/

  };
}
