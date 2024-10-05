{ ... }:

{
  # wofi launcher
  programs.wofi = {
    enable = true;
    settings = {
      prompt = "launch: ";
      term = "alacritty";
    };
  };

  # Lockscreen
  programs.hyprlock = {
    enable = true;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
        # Dark theme
        "GTK_THEME, Adawaita-dark"
        "QT_QPA_PLATFORMTHEME, qt5ct"
        "QT_STYLE_OVERRIDE, kvantum-dark"
      ];
      input = {
        # UK keyboard
        kb_layout = "gb";
      };
      # Keybindings - copy sway
      bind = [
        # Basic
        "SUPER, Return, exec, alacritty"
        "SUPER, f, fullscreen, 0"
        "SUPER_SHIFT, q, killactive"
        "SUPER_SHIFT, e, exit"
        "SUPER, d, exec, wofi -S drun"
        # Special - think scratchpad
        "SUPER_SHIFT, -, movetoworkspace, special"
        "SUPER, -, togglespecialworkspace"
        # Workspace
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 0"
        "SUPER_SHIFT, 1, movetoworkspace, 1"
        "SUPER_SHIFT, 2, movetoworkspace, 2"
        "SUPER_SHIFT, 3, movetoworkspace, 3"
        "SUPER_SHIFT, 4, movetoworkspace, 4"
        "SUPER_SHIFT, 5, movetoworkspace, 5"
        "SUPER_SHIFT, 6, movetoworkspace, 6"
        "SUPER_SHIFT, 7, movetoworkspace, 7"
        "SUPER_SHIFT, 8, movetoworkspace, 8"
        "SUPER_SHIFT, 9, movetoworkspace, 9"
        "SUPER_SHIFT, 0, movetoworkspace, 0"
        # Windows
        "SUPER_SHIFT, Space, togglefloating"
        "SUPER, Up, movefocus, u"
        "SUPER, Left, movefocus, l"
        "SUPER, Right, movefocus, r"
        "SUPER, Down, movefocus, d"
        "SUPER_SHIFT, Up, movewindow, u"
        "SUPER_SHIFT, Left, movewindow, l"
        "SUPER_SHIFT, Right, movewindow, r"
        "SUPER_SHIFT, Down, movewindow, d"        
      ];
      
    };
  };

  # Dark theme for apps
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Adwaita-dark  # Use your preferred dark theme here
  '';

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Adwaita-dark  # Dark theme for GTK4 apps
  '';
}
