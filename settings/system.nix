{ lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.system;
in
{
  # New options to be used between modules
  options.settings.system = {
    host = mkOption {
      type = types.str;
      default = "";
      description = "The networking hostname of the machine.";
    };
    user = mkOption {
      type = types.str;
      default = "";
      description = "The Linux user. The config does not support multiple users.";
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.host != "";
      message = "settings.system.host must be set.";
    }
    {
      assertion = cfg.user != "";
      message = "settings.system.user must be set.";
    }
  ];
}
