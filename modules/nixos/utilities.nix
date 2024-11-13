# Common packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Minimals
    kitty
    wget
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
