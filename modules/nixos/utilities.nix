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
    # Fun
    cmatrix
  ];
}
