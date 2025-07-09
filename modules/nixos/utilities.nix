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
