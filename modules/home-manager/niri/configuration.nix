{ inputs, pkgs, ... }:

{
  programs.niri = {
    settings = {
      # Keybinds overlay
      hotkey-overlay = {
        hide-not-bound = true;
        skip-at-startup = true;
      };
      input = {
        focus-follows-mouse.enable = true;
        keyboard.xkb.layout = "gb";
        touchpad.scroll-factor = 0.25;
        power-key-handling.enable = false;
      };
      overview = {
        zoom = 0.5;
      };
      spawn-at-startup = [
        { argv = [ "elephant" ]; } # TODO: USE CONFIG INSTEAD
      ];
      gestures.hot-corners.enable = false;
      window-rules = [

      ];
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
  programs.niri.settings.cursor = {
    theme = "phinger-cursors-light";
    size = 24;
  };
  ###
}
