{ pkgs, ... }:

{
  # Install the wootility app
  environment.systemPackages = with pkgs; [
    wootility
  ];
  
  # Enable required Wooting udev rules
  hardware.wooting.enable = true;
}
