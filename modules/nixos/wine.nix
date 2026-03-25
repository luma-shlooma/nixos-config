{ pkgs, ... }:

{
  # Some wine programs for various use
  environment.systemPackages = with pkgs; [
    wine-wayland
    winetricks
    bottles
  ];
}
