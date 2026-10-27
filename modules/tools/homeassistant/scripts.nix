{ config, lib, pkgs,... }:
with lib;
let
  # Module
  ha = config.modules.homeAssistant;
  # Script generator for HA action
  mkScript = name: entity: action: pkgs.writeShellScriptBin "${name}" ''
    #!/usr/bin/env bash
    ${pkgs.home-assistant-cli}/bin/hass-cli service call ${action} --arguments entity_id=${entity}
  '';
in
{
  # Options entirely dependent on my specific HA instance
  options.modules.homeAssistant.scripts = {
    # Toggle lamp
    toggleLamp = mkOption {
      type = types.nullOr types.path;
      default =  mkIf ha.enable (mkScript "ha-toggle-lamp" "switch.lamp" "switch.toggle");
      readOnly = true;
    };
    # Toggle manual
    toggleManual = mkOption {
      type = types.nullOr types.path;
      default = mkIf ha.enable (mkScript "ha-toggle-manual" "input_boolean.manual" "input_boolean.toggle");
      readOnly = true;
    };
  };
}
