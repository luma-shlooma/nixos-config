# Controlled Theme
{ config, lib, pkgs, ... }:

let
  colours = config.theme.colours;
  rgb = code: "rgb("+code+")";
  # rgba = code: alpha: "rgba("+code+alpha+")";
in
lib.mkIf (config.theme.name == "alpha")
{
  ### STYLE
  wayland.windowManager.hyprland = {
    settings = {
      general = {
        # These are mostly default values
        border_size = 1;
        no_border_on_floating = false;
        gaps_in = 5;
        gaps_out = 10;
        "col.inactive_border" = rgb colours.black;
        "col.active_border" = rgb colours.white;
      };
      decoration = {
        rounding = 0;
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        fullscreen_opacity = "1.0";
        dim_inactive = false;
        dim_special = "0.2";
        blur.enabled = false;
        shadow.enabled = false;
      };
      animations = {
        enabled = true;
        workspace_wraparound = false;
      };
      # Generally, these make the default animations faster
      animation = [
        "windows, 1, 2, default"
        "workspaces, 1, 2, default"
      ];
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        font_family = "JetBrains Mono";
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        background_color = rgb colours.true-black;
      };
    };
  };
  ###

  ### HAVE APPS USE DARK THEME / MODE
  # GTK settings
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
      # name = "Orchis";
      # package = (pkgs.orchis-theme.override { tweaks = ["black"]; });
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "gtk-theme" = "Adwaita-dark";
      # "gtk-theme" = "Orchis";
    };
    # Freedesktop
    "org/freedesktop/appearance" = {
      "color-scheme" = "prefer-dark";
    };
  };
  # QT
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
  };
  ###
}
