{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # Enable hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    # extraPackages
    environment.systemPackages = with pkgs; [
      hyprpicker    # Colour picker
      wl-clipboard  # Copy paste
      libnotify     # Send notifs
    ];

    environment.sessionVariables = {
      # Fix invisible cursor
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps
      NIXOS_OZONE_WL = "1";
      # Config dir
      XDG_CONFIG_HOME = "$HOME/.config";
    };

    # Set session if greeter is enabled
    settings.greeter.session = "start-hyprland";

    # Requires home-manager
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # General config
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        settings = {
          # UK keyboard
          input = {
            kb_layout = "gb";
          };
          # 'General' settings
          general = {
            layout = "dwindle";
            resize_on_border = true;
            extend_border_grab_area = 15;
            hover_icon_on_border = true;
            allow_tearing = false;
            # snap = {
            #   enabled = true;
            #   window_gap = 32;
            #   monitor_gap = 64;
            # };
          };
          misc = {
            # Adaptibe sync on games
            vrr = 3;
            # Window swallowing (term opens gui app)
            # Disabled bc of annoying cases like wev
            # enable_swallow = true;
            # swallow_regex = "^(Alacritty)$";
            close_special_on_empty = true;
          };
          binds = {
            hide_special_on_workspace_change = true;
          };
          # X11 compatability
          xwayland.enabled = true;
          opengl.nvidia_anti_flicker = true;
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
        };
      };

      ### CURSOR
      # Phisch Phinger cursor
      imports = [
        inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
      ];
      # Hyprcursor
      programs.hyprcursor-phinger.enable = true;
      # XCursor backup when hyprcursor fails
      home.pointerCursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        x11.enable = true;
        gtk.enable = true;
      };
      wayland.windowManager.hyprland.settings.cursor = {
        sync_gsettings_theme = true;
      };

      home.sessionVariables = {
        XCURSOR_THEME = "phinger-cursors-light";
        XCURSOR_SIZE = "24";
      };
      ###

    };

  };
}
