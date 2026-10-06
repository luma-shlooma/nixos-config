{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.launcher;
in
{
  # New options to be used between modules
  options.settings.launcher = {
    enable = mkEnableOption "launcher options";
    selected = mkOption {
      type = types.nullOr (types.enum [ "" "" ]);
      default = "";
      description = "The launcher to use. Must be set if the launcher option is enabled.";
    };
    launch = mkOption {
      type = types.str;
      default = "";
      description = "The command to open the laucher. Set by the launcher module.";
    };
    # 
    dmenu = mkOption {
      type = types.nullOr types.anything;
      default = null;
      description = "A function that accepts a newline-separated string of dmenu options and returns a string command that can be run to open those options for a user to select in dmenu mode. Set by the launcher module.";
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.enable -> cfg.name != "";
      message = "settings.launcher.name must be set if launcher options is enabled.";
    }
    {
      assertion = cfg.enable -> cfg.launch != "";
      message = "settings.launcher.launch must be set if launcher options is enabled.";
    }
    # dmenu can be null if not able to be implemented
    {
      assertion = cfg.dmenu != null -> builtins.isFunction cfg.dmenu && builtins.isString (cfg.dmenu "options" "prompt");
      message = "if set, settings.launcher.dmenu must be a function to that accepts a string and returns a string.";
    }
  ];
}
