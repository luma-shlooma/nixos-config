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
    # Networking
    inetutils
    nmap
    # Fun
    cmatrix
    gtypist
  ];
}
