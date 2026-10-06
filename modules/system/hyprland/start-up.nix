{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # The home-manager config
    home-manager.users.${user} = {

      # Map start-up commands to format
      wayland.windowManager.hyprland.settings."exec-once" = cfg.onStartUp;

    };

  };
}
