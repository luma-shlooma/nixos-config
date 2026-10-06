{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # The home-manager config
    home-manager.users."${user}" = {

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
        bind = [
          # Audio (pipewire)
          "SUPER, m, exec, ${mic_monitoring}/bin/toggle"
        ];
        bindl = [ # Works while locked
          "SUPER, Space, exec, playerctl play-pause"
          "SUPER, Alt_L, exec, playerctl previous"
          "SUPER, Alt_R, exec, playerctl next"
          "SUPER, code:108, exec, playerctl next" # Weird keyboard
        ];
      };

    };

  };
}
