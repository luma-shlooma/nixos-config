{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.settings.greeter;
  # The command to run tuigreet
  command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --cmd ${cfg.session}";
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "tuigreet")) {

    # Enable in greetd
    services.greetd = {
      enable = true;
      restart = true;
      settings = {
        initial_session = {
          command = if cfg.onBoot then "${command}" else "${cfg.session}";
          user = "${user}";
        };
        default_session = {
          command = "${command}";
          user = "${user}";
        };
      };
    };
    # Stop systemd screen littering
    # From https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

  };
}
