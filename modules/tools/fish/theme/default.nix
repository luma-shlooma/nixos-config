{ config, lib, pkgs, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Theme options
  theme = config.settings.theme.selected;
  # This module's config options
  cfg = config.modules.fish;
  # Prompt src
  prompt = pkgs.fetchFromGitHub {
    owner = "pure-fish";
    repo = "pure";
    rev = "39ef70d91421322d1f90828d1838f19891f7772c";
    hash = "sha256-H+PZZCP2ZHOLJ+IhFXeq2J/AsNk1cO4p0wcwJjN2Fr0=";
  };
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users.${user} = {

      # Theme fish
      programs.fish = {
        # Install prompt using plugins
        plugins = [
          { name = "pure"; src = prompt; }
        ];
        # Enable theme by sourcing it
        interactiveShellInit = ''
          source ${prompt}/functions/fish_prompt.fish
          source ${prompt}/functions/fish_title.fish
        '';
      };

    };

  };
}
