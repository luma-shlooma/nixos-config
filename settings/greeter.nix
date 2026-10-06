{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.greeter;
in
{
  # New options to be used between modules
  options.settings.greeter = {
    enable = mkEnableOption "Greeter Display Manager";
    selected = mkOption {
      type = types.nullOr (types.enum [ "tuigreet" "noctalia-greeter" ]);
      default = null;
      description = "The greeter to use. Must be set if the greeter setting is enabled.";
      example = "tuigreet";
    };
    session = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "The command run on a successful login attempt. Typically, this would run the desktop environment. Must be set if the greeter module is enabled.";
      example = "start-hyprland";
    };
    onBoot = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to greet the user on a fresh boot. Can be disabled if, for example, boot already prompts a disk-encryption key.";
      example = false;
    };
  };

  # Assertions on new options
  config.assertions = [
    {
      assertion = cfg.enable -> cfg.selected != null;
      message = "settings.greeter.selected must be set if greeter is enabled.";
    }
    {
      assertion = cfg.enable -> cfg.session != null;
      message = "settings.greeter.session must be set if greeter is enabled.";
    }
  ];
}
