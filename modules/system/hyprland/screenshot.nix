{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Home directory
  home = config.settings.system.homeDir;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  # lua generators
  lua = generators.mkLuaInline;
  bind = args: { _args = args; };
  mkdsp = dsp_name: param: lua "hl.dsp.${dsp_name}(${builtins.toString param})";
  exec = cmd: mkdsp "exec_cmd" "\"${cmd}\"";
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # The home-manager config
    home-manager.users.${user} = 
    let
      # Script to open editor in next free workspace
      # Only a separate script since `hyprshot` wants a single command
      # Could probably purpose this for other stuff too...
      # NOTE: Removing SUPER+S and use of this as it just got easy to miss-input
      # editimg = pkgs.writeShellScriptBin "editimg" ''
      #   #!/usr/bin/env bash
      #   hyprctl dispatch -- exec "[workspace empty]" xdg-open "$@"
      #  '';
       # Where to save screenshots
       screenshots = "${home}/Pictures/Screenshots";
    in
    {

      # Use hyprshot
      programs.hyprshot = {
        enable = true;
        saveLocation = screenshots;
      };

      # Set screenshot keybinds
      wayland.windowManager.hyprland.settings = {
        bind = builtins.map bind [
          # Win+Ctrl+S : Capture window
          [ "SUPER + CTRL + S" (exec "hyprshot -o ${screenshots} --mode window") ]
          # Win+Shift+S : Capture region
          [ "SUPER + SHIFT + S" (exec "hyprshot -o ${screenshots} --mode region") ]
          # Win+Ctrl+Shift+S : Colour picker
          [ "SUPER + CTRL + SHIFT + S" (exec "hyprpicker -an") ]
        ];
      };

    };

  };
}
