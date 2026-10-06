{ config, lib, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Home-manager config
  home = config."home-manager".users.${user};
  # Theme options
  theme = config.settings.theme.selected;
  # colours = config.settings.theme.colours;
  # This module's config options
  cfg = config.modules.zsh;
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users."${user}" = {

      # Theme zsh
      programs.zsh = {
        # Uses default alacritty colours
        # Theme set through oh-my-zsh
        oh-my-zsh = {
          theme = "pi";
          # TODO: Include pi theme in config - currently requires manual download
          custom = "${home.home.homeDirectory}/.oh-my-zsh/custom";
        };
      };

    };

  };
}
