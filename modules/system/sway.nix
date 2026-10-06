{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.wm;
in
{
  # Options - defined in wm.nix

  # Config
  config = mkIf (cfg.enable && (cfg.selected == "sway")) {

    # Keyring
    services.gnome.gnome-keyring.enable = true;

    # Enable sway
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        dmenu
        # Screenshots
        grim
        slurp
        # Clipboard
        wl-clipboard
        # Json query (used with swaymsg)
        jq
        # Backlight
        brightnessctl
        # Audio
        pamixer
      ];
    };

    # Set greeter session if enabled
    config.modules.greeter.session = "sway";

  };
}
