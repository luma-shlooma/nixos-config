{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  # Lua generators
  lua = generators.mkLuaInLine;
  exec = cmd: lua "hl.exec_cmd(\"${cmd}\")";
  startup = cmd: { _args = [ "hyprland.start" (exec cmd) ]; };
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {

    # The home-manager config
    home-manager.users.${user} = {

      # Map start-up commands to format
      wayland.windowManager.hyprland.settings.on = builtins.map startup cfg.onStartUp;

    };

  };
}
