args @ { ... }:

{
  # Make sure this is being used with the "home" host
  assertions =
  let
    assertLib = import ../../lib/assertions ({module = "home/haydn";}//args);
  in
  [ (assertLib.host "home") ];

  home.username = "haydn";
  home.homeDirectory = "/home/haydn";

  imports = builtins.map import [
    # Program Modules
    ../../modules/home-manager/common.nix
    ../../modules/home-manager/mpris
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/noctalia/default.nix
    ../../modules/home-manager/noctalia/home.nix
    ../../modules/home-manager/zsh
    ../../modules/home-manager/alacritty
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/yazi
    ../../modules/home-manager/firefox
    ../../modules/home-manager/homeassistant
    ../../modules/home-manager/easyeffects
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
