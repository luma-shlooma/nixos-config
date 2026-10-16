{ config, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.fish;
  pkg = pkgs.fish;
in
{
  # Options
  options.modules.fish.enable = mkEnableOption "fish";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Fish
      programs.fish = {
        enable = true;
        package = pkg;
        functions = {
          # Yazi navigator
          "y" = ''
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            command yazi $argv --cwd-file="$tmp"
            if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
              builtin cd -- "$cwd"
            end
            command rm -f -- "$tmp"
          '';
        };
        plugins = [
          { name = "z"; src = pkgs.fishPlugins.z.src; }
          { name = "done"; src = pkgs.fishPlugins.done.src; }
        ];
      };

    };

    # Set package if preferred
    settings.terminal.shell.package = mkIf (config.settings.terminal.shell.selected == "fish") pkg;

  };
}
