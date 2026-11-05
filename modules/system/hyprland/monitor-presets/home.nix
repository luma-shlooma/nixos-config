{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  preset = config.settings.hardware.monitorPreset;
  kanshi = config.modules.kanshi;
  # lua generators
  lua = generators.mkLuaInline;
  mkDsp = dsp_name: param: lua "hl.dsp.${dsp_name}(${builtins.toString param})";
  exec = cmd: mkDsp "exec_cmd" "\"${cmd}\"";
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland") && (preset == "home") && !kanshi.enable) {

    # Enable ddcutil (I forget exactly how this is used)
    modules.ddcutil.enable = true;

    # The home-manager config
    home-manager.users.${user} = 
    let
      # Monitor logic
      monitors = {
        main = {
          output = "DP-1";
          mode = "highrr";
          pos = "auto-center-left";
        };
        tv = {
          output = "HDMI-A-1";
          mode = "highres";
          pos = "auto-center-right";
        };
      };
      # Shorthand for enable/disable
      enable  = { disabled = false; };
      disable = { disabled = true; };
      # Options available to select from
      op_monitor = "Monitor";
      op_tv      = "TV";
      op_extend  = "Extend";
      op_mirror  = "Mirror";
      options = "${op_monitor}\n${op_tv}\n${op_extend}\n${op_mirror}";
      # hyprctl command
      # TODO: Should use reference to exact pkg
      hyprctl_mon = output: enable: "hyprctl -r eval hl.monitor({ output=\"${output}\", disabled=${if enable then "false" else "true"} })";
      hyprctl_mir = output: mirror: "hyprctl -r eval hl.monitor({ output=\"${output}\", disabled=false, mirror=\"${mirror}\" })";
      # Script to make and action selection
      reconfigure = pkgs.writeShellScriptBin "monitors" ''
        #!/usr/bin/env bash
        set -e
        CHOSEN=$(${config.settings.launcher.dmenu options "Select Monitor Configuration"})
        case "$CHOSEN" in
          "${op_monitor}")
            ${hyprctl_mon monitors.main.output true}
            ${hyprctl_mon monitors.tv.output false}
            ;;
          "${op_tv}")
            ${hyprctl_mon monitors.main.output false}
            ${hyprctl_mon monitors.tv.output true}
            ;;
          "${op_extend}")
            ${hyprctl_mon monitors.main.output true}
            ${hyprctl_mon monitors.tv.output true}
            ;;
          "${op_mirror}")
            ${hyprctl_mon monitors.main.output true}
            ${hyprctl_mir monitors.tv.output monitors.main.output}
            ;;
        esac
      '';
    in
    {

      # Add that script to home
      home.packages = [ reconfigure ];
      # Apply to hyprland
      wayland.windowManager.hyprland = {
        settings = {
          # Default setup
          monitor = [
            (monitors.main // enable)
            (monitors.tv // disable)
          ];
          # Add keybind to prompt on SUPER+P
          bind._args = [ "SUPER + P" (exec "${reconfigure}/bin/monitors") ];
        };
      };

    };

  };
}
