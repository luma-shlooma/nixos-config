{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.utilities;
in
{
  # Options
  options.modules.utilities.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable random utility packages. It is best to leave this enabled so that you have some minimal tools to navigate.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {
    # Common packages
    environment.systemPackages = with pkgs; [
      # TODO: Separate some of these out if they are not "core"
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
    ];
  };
}
