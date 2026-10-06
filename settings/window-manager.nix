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
      type = types.nullOr (types.enum [ "hyprland" "niri" ]);
      default = null;
      description = "The window manager to use.";
      example = "hyprland";
    };
    onStartUp = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Commands the selected window-manager should run on start-up.";
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.enable -> cfg.selected != null;
      message = "modules.windowManager.selected must be set if window-manager is enabled.";
    }
  ];
}
