{ config, lib, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Home-manager config
  home = config.home-manager.users.${user};
  # Theme options
  theme = config.settings.theme.selected;
  colours = config.settings.theme.colours;
  # Hex formatter & niri decoration formatter for a basic colour
  hex = code: "#${code}";
  dec = code: { color = hex code; };
  # This module's config options
  cfg = config.settings.windowManager;
in
{
  config = mkIf (cfg.enable && (cfg.selected == "niri") && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users."${user}" = {

      ### NIRI STYLE
      programs.niri.settings = {
        overview.backdrop-color = hex colours.dark-black;
        layout = {
          background-color = hex colours.true-black;
          border.enable = false;
          focus-ring = {
            enable = true;
            width = 1;
            active   = dec colours.dark-white;
            inactive = dec colours.dark-black;
            urgent   = dec colours.dark-yellow;
          };
          insert-hint = {
            enable = true;
            display = dec colours.dark-black;
          };
          always-center-single-column = true;
          center-focused-column = "always";
          tab-indicator.enable = false;
          gaps = 6;
          struts.left = 2;
          struts.right = 2;
        };
        prefer-no-csd = true;
      };

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
        gtk4.theme = home.gtk.theme;
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
