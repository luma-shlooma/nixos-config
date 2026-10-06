{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.homeAssistant;
in
{
  # Options
  options.modules.homeAssistant = {
    enable = mkEnableOption "Home Assistant CLI";
    server = mkOption {
      type = types.str;
      default = "";
      description = "HTTP URL of the running home-assistant server.";
      example = "http://homeassistant.lan:8123";
    };
    token = mkOption {
      type = types.str;
      default = "";
      description = "Secret token to access the home-assistant server.";
    };
  };

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Add home assistant cli tool
      home.packages = with pkgs; [ home-assistant-cli ];

      # Set env vars
      home.sessionVariables = {
        "HASS_SERVER" = "${cfg.server}";
        "HASS_TOKEN"  = "${cfg.token}";
      };

    };

  };
}
