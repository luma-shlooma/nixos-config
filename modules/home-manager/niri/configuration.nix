{ ... }:

# TODO: Theming pattern
{
  programs.niri = {
    settings = {
      # Keybinds overlay
      hotkey-overlay = {
        # NOTE: may want to hide & skip when familar with keybinds
        hide-not-bound = false;
        skip-at-startup = false;
      };
      input = {
        focus-follows-mouse.enable = true;
        keyboard.xkb.layout = "gb";
        power-key-handling.enable = false;
      };
      overview = {
        backdrop-color = "#000000";
      };
    };
  };
}
