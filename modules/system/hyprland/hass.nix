{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  ha = config.modules.homeAssistant;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland") && ha.enable) {

    # The home-manager config
    home-manager.users.${user} = {
      # Add script to keybinds
      wayland.windowManager.hyprland.settings = {
        env = [
          # Copy over the required env vars
          "HASS_SERVER, ${ha.server}"
          "HASS_TOKEN, ${ha.token}"
        ];
        bind = [
          # Home assistant binding is hass-cli is configured
          "SUPER, l, exec, ${ha.scripts.toggleLamp}"
          "SUPER_SHIFT, l, exec, ${ha.scripts.toggleManual}"
        ];
      };

    };

  };
}
