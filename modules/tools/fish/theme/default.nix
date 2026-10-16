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
    owner = "smolijar";
    repo = "theme-pie";
    rev = "cae447f3f2318449dde9341b807fc59813a305d9";
    hash = "sha256-xb9ssEkSVB58LZ7AmwavqAXy4LJ5GT0+LdIz5QgiFiw=";
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
          { name = "pie"; src = prompt; }
        ];
        # Enable theme by sourcing it
        interactiveShellInit = strings.concatStrings (strings.intersperse "\n" ([
          "source ${prompt}/fish_prompt.fish"
          "source ${prompt}/fish_right_prompt.fish"
          "source ${prompt}/fish_title.fish"
        ]));
      };

    };

  };
}
