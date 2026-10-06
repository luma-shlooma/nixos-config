{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.greeter;
in
{
  # Options
  options.modules.greeter = {
    enable = mkEnableOption "Greeter Display Manager";
    selected = mkOption {
      type = types.nullOr (types.enum [ "tuigreet" "noctalia-greeter" ]);
      default = null;
      description = "The greeter to use. Must be set if the greeter module is enabled.";
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

  # Config
  config = mkIf cfg.enable {

    # Assertions to check required options
    assertions = [
      {
        assertion = cfg.selected != null;
        message = "modules.greeter.selected must be set if greeter is enabled.";
      }
      {
        assertion = cfg.session != null;
        message = "modules.greeter.session must be set if greeter is enabled.";
      }
    ];

  };
}
