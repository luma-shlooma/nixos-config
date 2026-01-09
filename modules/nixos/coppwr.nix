{ pkgs, ... }:

{
  # Coppwr for audio control
  environment.systemPackages = with pkgs; [
    coppwr
  ];
}
