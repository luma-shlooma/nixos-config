{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Home-manager config
  home = config.home-manager.users.${user};
  # This module's config options
  cfg = config.modules.alacritty;
in
{
  # Options
  options.modules.alacritty.enable = mkEnableOption "Alacritty";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Enable alacritty
      programs.alacritty.enable = true;

    };

    # Set package if preferre
    settings.terminal.app.package = mkIf (config.settings.terminal.app.selected == "alacritty") home.programs.alacritty.package;

  };
}
