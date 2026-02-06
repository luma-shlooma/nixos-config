{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mullvad-vpn # Client
    mullvad     # CLI
  ];

  services.mullvad-vpn.enable = true;
}
