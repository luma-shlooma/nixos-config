{ pkgs, ... }:

{
  # Install VLC
  environment.systemPackages = with pkgs; [
    vlc
  ];
}
