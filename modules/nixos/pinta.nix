{ pkgs, ... }:

{
  # Pinta image editing software
  environment.systemPackages = [
    pkgs.pinta
  ];
}
