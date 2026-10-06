{ config, lib, pkgs, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Theme options
  theme = config.settings.theme.selected;
  colours = config.settings.theme.colours;
  # Formatter
  rgb = code: "rgb("+code+")";
  # rgba = code: alpha: "rgba("+code+alpha+")";
  # This module's config options
  cfg = config.settings.windowManager;
in
{
  config = mkIf (cfg.enable && (cfg.selected == "hyprland") && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users.${user} = {

      ### STYLE
      wayland.windowManager.hyprland = {
        settings = {
          general = {
            # These are mostly default values
            border_size = 1;
            gaps_in = 4;
            gaps_out = 8;
            "col.inactive_border" = rgb colours.black;
            "col.active_border" = rgb colours.white;
          };
          decoration = {
            rounding = 4;
            rounding_power = 4.0;
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
        gtk4.theme = config.gtk.theme;
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

    };

  };
}
