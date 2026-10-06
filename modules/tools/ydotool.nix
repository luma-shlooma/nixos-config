{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.ydotools;
in
{
  # Options
  options.modules.ydotool.enable = mkEnableOption "ydotools";

  # Config
  config = mkIf cfg.enable {

    programs.ydotool = {
      group = "ydotool";
      enable = true;
    };

    users.users.${user}.extraGroups = [ "ydotool" ];

  };
}
