args @ { ... }:

{
  # Make sure this is being used with the "work" host
  assertions =
  let
    assertLib = import ../../lib/assertions ({module = "work/haydn";}//args);
  in
  [ (assertLib.host "work") ];

  home.username = "haydn";
  home.homeDirectory = "/home/haydn";

  imports = builtins.map import [
    # Program Modules
    ../../modules/home-manager/common.nix
    ../../modules/home-manager/bash
    ../../modules/home-manager/niri
    # ../../modules/home-manager/sway
    ../../modules/home-manager/zsh
    ../../modules/home-manager/alacritty
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/yazi
    ../../modules/home-manager/firefox
    ../../modules/home-manager/kanshi
    # ../../modules/home-manager/toucher
    # Option Modules
    ../../options/theme/default.nix
    ../../options/apps/default.nix
    # Set Theme
    ../../options/theme/presets/alpha.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
