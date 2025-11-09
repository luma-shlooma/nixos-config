{ config, pkgs, ... }:

let
  # Script to open editor in next free workspace
  # Only a separate script since `hyprshot` wants a single command
  # Could probably purpose this for other stuff too...
  editimg = pkgs.writeShellScriptBin "editimg" ''
    #!/usr/bin/env bash
    hyprctl dispatch -- exec "[workspace empty]" xdg-open "$@"
   '';
   # Where to save screenshots
   screenshots = "${config.home.homeDirectory}/Pictures/Screenshots";
in
{
  # Use hyprshot
  programs.hyprshot = {
    enable = true;
    saveLocation = screenshots;
  };

  # Set screenshot keybinds
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Win+S : Capture full screen w/ editor (best for games)
      "SUPER, s, exec, [workspace +1] hyprshot -o ${screenshots} --mode active --mode output -- ${editimg}/bin/editimg"
      # Win+Ctrl+S : Capture window
      "SUPER_CTRL, s, exec, hyprshot -o ${screenshots} --mode window"
      # Win+Shift+S : Capture region
      "SUPER_SHIFT, s, exec, hyprshot -o ${screenshots} --mode region"
      # Win+Ctrl+Shift+S : Colour picker
      "SUPER_CTRL_SHIFT, s, exec, hyprpicker -an"
    ];
  };
}
