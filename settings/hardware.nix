{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.hardware;

  # Default monitor sets
  defOutputs = {
    home-pc = {
      monitor = "DP-1";
      tv = "HDMI-A-1";
    };
    thinkpad-t14 = {
      laptop = "eDP-1";
      # NOTE: The BenQ monitors are best tracked using other criteria.
      #       See the niri monitor config for how that is done.
    };
  };
in
{
  # New options to be used between modules
  options.settings.hardware = {
    device = mkOption {
      type = types.nullOr (types.enum [ "home-pc" "thinkpad-t14" ]);
      default = null;
      description = "The specific device of this machine. Used to enable specific hardware modules.";
      example = "laptop";
    };
    form = mkOption {
      type = types.nullOr (types.enum [ "desktop" "laptop" "server" ]);
      default = 
        if      cfg.device == "home-pc" then "desktop"
        else if cfg.device == "thinkpad-t14" then "laptop"
        else null;
      description = "The form factor of this machine. Modules can use this for layout choices.";
      example = "desktop";
    };
    outputs = {
      primary = mkOption {
        type = types.nullOr types.str;
        default = 
          if      cfg.device == "home-pc" then defOutputs.home-pc.monitor
          else if cfg.device == "thinkpad-t14" then defOutputs.thinkpad-t14.laptop
          else null;
        description = "The primary output for the specific device.";
      };
      all = mkOption {
        type = types.attrsOf types.str;
        default =
          if      cfg.device == "home-pc" then defOutputs.home-pc
          else if cfg.device == "thinkpad-t14" then defOutputs.thinkpad-t14
          else {};
        description = "All available outputs by aliases.";
      };
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.device != null;
      message = "settings.hardware.device must be specified.";
    }
    {
      assertion = cfg.form != null;
      message = "settings.hardware.form must be specified if not set by the device.";
    }
  ];

}
