{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.time;
in
{
  # Options
  options.modules.time.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable time. Unlikely this can be disabled without issues.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {

    # NOTE: I have no need to option-ise the following

    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

  };
}
