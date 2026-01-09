{ pkgs, ... }:

{
  # Thunar file explorer
  environment.systemPackages = with pkgs; [
    thunar
  ];
}
