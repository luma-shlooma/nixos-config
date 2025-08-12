{ inputs, pkgs, ... }:

{
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

}
