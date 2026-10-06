{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.hardware;
in
{
  # New options to be used between modules
  options.settings.hardware = {
    form = mkOption {
      type = types.nullOr (types.enum [ "desktop" "laptop" "server" ]);
      default = null;
      description = "The form factor of this machine. Modules can use this for layout choices.";
      example = "desktop";
    };
    device = mkOption {
      type = types.nullOr (types.enum [ "home-pc" "thinkpad-t14" ]);
      default = null;
      description = "The specific device of this machine. Used to enable specific hardware modules.";
      example = "laptop";
    };
    monitorPreset = mkOption {
      type = types.nullOr (types.enum [ "home" "orion" ]);
      default = null;
      description = "The enabled monitor preset for this machine. Some modules will use this to implement specific monitor workspace layouts.";
      example = "orion";
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.form != null;
      message = "settings.hardware.form must be specified if not set by the device.";
    }
    {
      assertion = cfg.device != null;
      message = "settings.hardware.device must be specified.";
    }
  ];

  # Set forms based on devices
  config.settings.form = if cfg.device == "home-pc" then "desktop"
                    else if cfg.device == "thinkpad-t14" then "laptop"
                    else null; # NOTE: This might clash with a manual assignment
}
