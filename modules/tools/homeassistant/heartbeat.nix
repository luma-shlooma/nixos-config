{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # This module's config options
  cfg = config.modules.homeAssistant;
in
{
  # Options
  options.modules.homeAssistant.heartbeat.enable = mkEnableOption "heartbeat sent to the HA server from this machine";

  # Config
  config = mkIf (cfg.enable && cfg.heartbeat.enable) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Run the script as a user-level service
      systemd.user.services.hass-heartbeat = 
      let
        # Script to send a pulse to HA to let it know the PC is on
        heartbeatScript = pkgs.writeShellScriptBin "hass-heartbeat" ''
          #!${pkgs.bash}/bin/bash
          echo "Starting Home Assistant heartbeat service (managed by home-manager)..."
          sleep 10
          while true; do
            TIMESTAMP=''$(date +%s)
            echo "Sending heartbeat: ''${TIMESTAMP}"
            ${pkgs.home-assistant-cli}/bin/hass-cli service call input_number.set_value --arguments "entity_id=input_number.pc_last_heartbeat,value=''${TIMESTAMP}"
            sleep 60
          done
        '';
        # Access session variables set in configuration.nix
        vars = config.home-manager.users."${user}".home.sessionVariables;
      in
      {
        Unit.Description = "Home Assistant PC Heartbeat Service";
        Unit.After = [ "network-online.target" ];
        Service.ExecStart = "${heartbeatScript}/bin/hass-heartbeat";
        Service.Restart = "always";
        Service.RestartSec = "10s";
        Service.Environment = [
          "PATH=/run/current-system/sw/bin"
          "HASS_SERVER=${vars.HASS_SERVER}"
          "HASS_TOKEN=${vars.HASS_TOKEN}"
        ];
        Install.WantedBy = [ "default.target" ];
      };

    };

  };
}
