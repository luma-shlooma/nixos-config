{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.ydotool;
in
{
  # Options
  options.modules.ydotool.enable = mkEnableOption "ydotool";

  # Config
  config = mkIf cfg.enable {

    programs.ydotool = {
      group = "ydotool";
      enable = true;
    };

    users.users.${user}.extraGroups = [ "ydotool" ];

  };
}
