{ config, lib, ... }:

let
  # Command to toggle lamp
  # Should all hass commands be an option set?
  toggle-lamp = "\"$(hass-cli service call switch.toggle --arguments entity_id=switch.lamp)\"";
in
lib.mkIf (config.apps.hasConfigured "hass-cli") {
  wayland.windowManager.hyprland.settings = {
    env = [
      # Copy over the required env vars
      "HASS_SERVER, ${config.home.sessionVariables."HASS_SERVER"}"
      "HASS_TOKEN, ${config.home.sessionVariables."HASS_TOKEN"}"
    ];
    bind = [
      # Home assistant binding is hass-cli is configured
      "SUPER, l, exec, ${toggle-lamp}"
    ];
  };
}
