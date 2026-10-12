{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.kitty;
  pkg = pkgs.kitty;
in
{
  # Options
  options.modules.kitty.enable = mkEnableOption "Kitty";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Enable kitty
      programs.kitty = {
        enable = true;
        package = pkg;
        settings = {
          # Cursor
          cursor_shape = "block";
          cursor_shape_unfocused = "hollow";
          shell_integration = "no-cursor";
          # Remove close confirmation
          confirm_os_window_close = 0;
          # Remove bell audio
          enable_audio_bell = false;
        };
      };

    };

    # Set package if preferred
    settings.terminal.app.package = mkIf (config.settings.terminal.app.selected == "kitty") pkg;

  };
}
