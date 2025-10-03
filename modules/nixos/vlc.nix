{ pkgs, ... }:

{
  # Install VLC
  environment.systemPackages = [
    pkgs.vlc
  ];
}
