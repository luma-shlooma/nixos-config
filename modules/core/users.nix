{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.user;
in
{
  # Options
  options.modules.user.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable the user. Unlikely this can be disabled without issues.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {

    # Common user account
    users.users."${user}" = {
      isNormalUser = true;
      description = "${user}";
      # TODO: Perhaps make these conditional on modules
      extraGroups = [ "networkmanager" "wheel" "conf" "video" "audio" "docker" "lxc-user" "wireshark" "dialout" ];
      shell = config.settings.terminal.shell.package;
      ignoreShellProgramCheck = true;
    };

  };
}
