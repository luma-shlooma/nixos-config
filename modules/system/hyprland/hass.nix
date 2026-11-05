{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  ha = config.modules.homeAssistant;
  # Lua generators
  args = args: { _args = args; };
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
          (args [ "HASS_SERVER" "${ha.server}" ])
          (args [ "HASS_TOKEN" "${ha.token}" ])
        ];
        # Bindings moved to bindings.nix
      };

    };

  };
}
