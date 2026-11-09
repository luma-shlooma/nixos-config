{ config, lib, ... }:
with lib;
let
  # The user
  user = config.settings.user;
  # This module's config options
  cfg = config.modules.tcpdump;
in
{
  # Options
  options.modules.tcpdump.enable = mkEnableOption "tcpdump";

  # Config
  config = mkIf cfg.enable {

    programs.tcpdump.enable = true;

    users.users.${user}.extraGroups = [ "pcap" ];

  };
}
