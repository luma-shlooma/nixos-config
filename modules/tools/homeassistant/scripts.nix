{ config, lib, pkgs,... }:
with lib;
let
  # Module
  ha = config.modules.homeAssistant;
  # Script generator for HA action
  mkScript = name: succNotif: entity: action: "${pkgs.writeShellScriptBin "${name}" ''
    #!/usr/bin/env bash
    ${pkgs.home-assistant-cli}/bin/hass-cli service call ${action} --arguments entity_id=${entity} && \
    notify-send "${succNotif}" -t 800
  ''}/bin/${name}";
in
{
  # Options entirely dependent on my specific HA instance
  options.modules.homeAssistant.scripts = {
    # Toggle lamp
    toggleLamp = mkOption {
      type = types.nullOr types.str;
      default = if ha.enable then (mkScript "ha-toggle-lamp" "Toggled Lamp" "switch.lamp" "switch.toggle") else null;
      readOnly = true;
    };
    # Toggle manual
    toggleManual = mkOption {
      type = types.nullOr types.str;
      default = if ha.enable then (mkScript "ha-toggle-manual" "Toggled Manual" "input_boolean.manual" "input_boolean.toggle") else null;
      readOnly = true;
    };
  };
}
