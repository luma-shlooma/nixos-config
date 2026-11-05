{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  # lua generators
  lua = generators.mkLuaInline;
  bind = args: { _args = args; };
  locked = { locked = true; };
  mkdsp = dsp_name: param: lua "hl.dsp.${dsp_name}(${builtins.toString param})";
  exec = cmd: mkdsp "exec_cmd" "\"${cmd}\"";
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # The home-manager config
    home-manager.users.${user} = {

      # Add sound binds and mic monitoring script
      wayland.windowManager.hyprland.settings =
      let
        # Script to toggle mic monitoring in pipewire
        mic_monitoring = pkgs.writeShellScriptBin "toggle" ''
          #!/usr/bin/env bash

          if [ -z "$(pgrep pw-loopback)" ]; then
              # Start loopback
              ${pkgs.pipewire}/bin/pw-loopback &
          else
              # Kill loopback
              pkill pw-loopback
          fi
        '';
      in
      {
        bind = builtins.map bind [
          # Audio (pipewire)
          [ "SUPER + M" (exec "${mic_monitoring}/bin/toggle") ]
          [ "SUPER + Space" (exec "playerctl play-pause") locked ]
          [ "SUPER + Alt_L" (exec "playerctl previous") locked ]
          [ "SUPER + Alt_R" (exec "playerctl next") locked ]
          [ "SUPER + code:108" (exec "playerctl next") locked ] # Weird keyboard
        ];
      };

    };

  };
}
