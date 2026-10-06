{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.xdg;
  wm = config.settings.windowManager;
in
{
  # Options
  options.modules.xdg.enable = mkEnableOption "XDG";

  # Config
  config = mkIf cfg.enable {

    # Allow app query XDG
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
        hyprland = mkIf (wm.enable && (wm.selected == "hyprland")) {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
        };
      };
    };

  };
}
