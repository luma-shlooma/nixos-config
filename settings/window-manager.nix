{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.windowManager;
in
{
  # New options to be used between modules
  options.settings.windowManager = {
    enable = mkEnableOption "Window Manager";
    selected = mkOption {
      type = types.nullOr (types.enum [ "hyprland" "niri" "sway" ]);
      default = null;
      description = "The window manager to use.";
      example = "hyprland";
    };
    onStartUp = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Commands the selected window-manager should run on start-up.";
    };
    monitorPreset = mkOption {
      type = types.nullOr (types.enum [ "home" "orion" ]);
      default = null;
      description = "An optional preset for monitor configuration.";
      example = "orion";
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.enable -> cfg.selected != null;
      message = "modules.wm.selected must be set if wm is enabled.";
    }
  ];
}
