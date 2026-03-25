# Common packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Minimals
    kitty
    wget
    file
    gnumake
    git
    vim
    tmux
    htop
    ripgrep
    tree
    swayimg
    # Networking
    inetutils
    nmap
    # Hardware
    usbutils
    # Fun
    cmatrix
    gtypist
    gemini-cli
  ];
}
