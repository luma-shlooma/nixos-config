{ pkgs, ... }:

{
  # Req for oci template
  environment.systemPackages = with pkgs; [ skopeo umoci ];

  virtualisation.lxc = {
    enable = true;
    unprivilegedContainers = true;
    #usernetConfig = ''
    #  @lxc-user veth lxcbr0 3
    #'';
    # bridgeConfig = ''
    #   USE_LXC_BRIDGE="true"
    #   LXC_BRIDGE="lxcbr0"
    #   LXC_ADDR="10.0.3.1"
    #   LXC_NETMASK="255.255.255.0"
    #   LXC_NETWORK="10.0.3.0/24"
    #   LXC_DHCP_RANGE="10.0.3.2,10.0.3.254"
    #   LXC_DHCP_MAX="253"
    #   LXC_DHCP_CONFILE=""
    #   LXC_DOMAIN=""
    # ''; 
  };
}
