{ config, pkgs, ... }:

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
in
{
  # Run the script as a user-level service
  systemd.user.services.hass-heartbeat = {
    Unit.Description = "Home Assistant PC Heartbeat Service";
    Unit.After = [ "network-online.target" ];
    Service.ExecStart = "${heartbeatScript}/bin/hass-heartbeat";
    Service.Restart = "always";
    Service.RestartSec = "10s";
    Service.Environment = [
      "PATH=/run/current-system/sw/bin"
      "HASS_SERVER=${config.home.sessionVariables.HASS_SERVER}"
      "HASS_TOKEN=${config.home.sessionVariables.HASS_TOKEN}"
    ];
    Install.WantedBy = [ "default.target" ];
  };
}
