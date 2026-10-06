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
  options.modules.homeAssistant.enable = mkEnableOption "Home Assistant CLI";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Add home assistant cli tool
      home.packages = with pkgs; [ home-assistant-cli ];

      # Set env vars
      # TODO: Make secret
      home.sessionVariables = {
        "HASS_SERVER" = "http://homeassistant.lan:8123";
        "HASS_TOKEN"  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiYTQwYjQzZGM2YzA0Zjg4Yjg5Y2I0OGI0YTlhMzE4NSIsImlhdCI6MTc2MDc4NjIwMCwiZXhwIjoyMDc2MTQ2MjAwfQ.IqcDN1rT2KNnc4tQlAq6Ja_TP4xpYs-W6Q2TGxhtW7w";
      };

    };

  };
}
