{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  ha = config.modules.homeAssistant;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland") && ha.enable) {

    # The home-manager config
    home-manager.users."${user}" =
    let
      # Vars
      vars = config.home-manager.users."${user}".home.sessionVariables;
      # Command to toggle lamp
      # Should all hass commands be an option set?
      toggle-lamp = "\"$(${pkgs.home-assistant-cli}/bin/hass-cli service call switch.toggle --arguments entity_id=switch.lamp)\"";
    in
    {
      # Add script to keybinds
      wayland.windowManager.hyprland.settings = {
        env = [
          # Copy over the required env vars
          "HASS_SERVER, ${vars."HASS_SERVER"}"
          "HASS_TOKEN, ${vars."HASS_TOKEN"}"
        ];
        bind = [
          # Home assistant binding is hass-cli is configured
          "SUPER, l, exec, ${toggle-lamp}"
        ];
      };

    };

  };
}
