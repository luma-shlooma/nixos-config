{ config, lib, ... }:
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
    homeDir = mkOption {
      type = types.str;
      default = "";
      description = "The user home directory for the user. Auto-generated based on user.";
    };
    configDir = mkOption {
      type = types.str;
      default = "";
      description = "The user config directory for the user. Auto-generated based on user.";
    };
  };

  # Set home & config directory based on user
  config.settings.system.homeDir = "/home/${cfg.user}";
  config.settings.system.configDir = "${cfg.homeDir}/.config";

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
