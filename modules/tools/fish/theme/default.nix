{ config, lib, pkgs, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Home directory
  # home = config.settings.system.homeDir;
  # Theme options
  theme = config.settings.theme.selected;
  # colours = config.settings.theme.colours;
  # This module's config options
  cfg = config.modules.fish;
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users.${user} = {

      # Theme fish
      programs.fish = {
        # Set prompt using plugin
        plugins = [
          {
            name = "pie";
            src = pkgs.fetchFromGitHub {
              owner = "smolijar";
              repo = "theme-pie";
              rev = "cae447f3f2318449dde9341b807fc59813a305d9";
              hash = "sha256-xb9ssEkSVB58LZ7AmwavqAXy4LJ5GT0+LdIz5QgiFiw=";
            };
          }
        ];
      };

    };

  };
}
