{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      # Keybindings - copy sway
      bind = [
        # Basic
        "SUPER, Return, exec, alacritty"
        "SUPER, f, fullscreen, 0"
        "SUPER_SHIFT, q, killactive"
        "SUPER_SHIFT, e, exit"
        "SUPER, d, exec, rofi -show drun -show-icons"
        "SUPER, code:49, exec, hyprlock" # ` key
        # Special - think scratchpad
        "SUPER_SHIFT, code:20, movetoworkspacesilent, special" # - key
        "SUPER, code:20, togglespecialworkspace"
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
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER_SHIFT, 0, movetoworkspacesilent, 0"
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
      binds = {
        # Allow for click binds
        drag_threshold = 10;
      };
      # Mouse bindings
      bindm = [
        # Drag window   - SUPER + LMB + DRAG
        "SUPER, mouse:272, movewindow"
        # Resize window - SUPER + RMB + DRAG
        "SUPER, mouse:273, resizewindow"
      ];
      bindc = [
        # Toggle float  - SUPER + RMB
        "SUPER, mouse:273, togglefloating"
        # Kill window   - SUPER + MMB
        "SUPER, mouse:274, killactive"
      ];
    };
  };
}
