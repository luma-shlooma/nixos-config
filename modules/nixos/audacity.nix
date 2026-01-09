{ pkgs, ... }:

{
  # Audacity
  environment.systemPackages = with pkgs; [
    audacity
  ];
}
