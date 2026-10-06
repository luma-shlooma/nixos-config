{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.networking;
in
{
  # Options
  options.modules.networking.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable networking. Unlikely this can be disabled without issues.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {

    # Define your hostname
    networking.hostName = "${config.settings.system.host}";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      # settings = {
      #   KexAlgorithms = [
      #     #"diffie-hellman-group1-sha1"
      #   ];
      # };
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Windows ttl spoof - didn't work for one use case, might be useful another time
    # networking.firewall.extraCommands = ''
    #   iptables -t mangle -A OUTPUT -j TTL --ttl-set 128
    #   iptables -t mangle -A OUTPUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1400
    # '';

  };
}
