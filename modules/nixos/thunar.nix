{ pkgs, ... }:

{
  # Thunar file explorer
  environment.systemPackages = [
    pkgs.xfce.thunar
  ];
}
