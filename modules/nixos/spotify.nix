{ pkgs, ... }:

{
  # Spotify
  environment.systemPackages = with pkgs; [
    spotify
  ];
}
