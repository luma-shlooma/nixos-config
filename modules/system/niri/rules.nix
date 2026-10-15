{ config, inputs, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "niri")) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Configure in home-manager
      programs.niri.settings._children = [
        {
          # All window rules
          window-rule._children = [
            # Increase kitty terminal width
            { match._props = { app-id = "kitty"; at-startup = true; }; }
            { default-column-width._props = { fixed = 800; }; }
          ];
        }
      ];

    };

  };
}
