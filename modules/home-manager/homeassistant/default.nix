{ pkgs, ... }:

{
  imports = [
    ./option.nix
  ];
  
  # Add home assistant cli tool
  home.packages = with pkgs; [ home-assistant-cli ];

  # Set env vars
  home.sessionVariables = {
    "HASS_SERVER" = "http://homeassistant:8123";
    "HASS_TOKEN"  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiYTQwYjQzZGM2YzA0Zjg4Yjg5Y2I0OGI0YTlhMzE4NSIsImlhdCI6MTc2MDc4NjIwMCwiZXhwIjoyMDc2MTQ2MjAwfQ.IqcDN1rT2KNnc4tQlAq6Ja_TP4xpYs-W6Q2TGxhtW7w";
  };
}
