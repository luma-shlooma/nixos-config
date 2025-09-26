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
  ### Note: This only partially works, needs fixing
  # GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
  };
  # Freedesktop
  dconf.settings = {
    "org/freedesktop/appearance" = {
      "color-scheme" = "prefer-dark";
    };
  };
  # QT
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "kvantum";
      package = pkgs.pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };
  home.packages = [
    pkgs.libsForQt5.qtstyleplugin-kvantum
  ];
  ###
}
