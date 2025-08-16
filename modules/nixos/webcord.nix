{ pkgs, ... }:

{
  # Webcord
  # Hardened and built-for-wayland discord client

  environment.systemPackages = with pkgs; [
    webcord
  ];
}
