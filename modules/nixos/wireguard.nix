{ pkgs, ... }:

{
  # Obviously requires networking
  imports = [
    ./network.nix
  ];

  # wg-tools
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  
  # Allow wireguard connections through firewall
  networking.firewall.checkReversePath = "loose";

  # Setup using https://joshbuker.com/blog/how-to-use-wireguard-on-nixos-with-gnome/
}
