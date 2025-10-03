{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
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
        enable_swallow = true;
        swallow_regex = "^(Alacritty)$";
        close_special_on_empty = true;
        new_window_takes_over_fullscreen = 2;
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
  # This used to be in theme, but `imports` is not supported
  # Phisch Phinger theme
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
}
