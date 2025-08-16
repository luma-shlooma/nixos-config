{ pkgs, ... }:

{
  # Discord
  environment.systemPackages = with pkgs; [
    discord
  ];
}
