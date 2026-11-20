{ config, inputs, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # The primary output
  primary = config.settings.hardware.outputs.primary;
  # This module's config options
  cfg = config.settings.greeter;
in
{

  # Import module
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Config
  config = mkIf (cfg.enable && (cfg.selected == "noctalia-greeter")) {

    services.displayManager.noctalia-greeter = {
      enable = true;
      greeter-args = "";
      passwordless-sync-users = [ user ];
      settings = {
        # Default session and user
        session.default = cfg.session;
        user.default = user;
        # Copy most of appearance from noctalia
        # TODO: Make themed off settings
        appearance = {
          scheme = "Synced";
          password_style = "default";
          hide_logo = true;
          # scheme_selector_position = "hidden";
          theme_mode = "dark";
          wallpaper.fill_color = "#000000";
        };
        output.name = mkIf (primary != null) primary;
        # TODO
        cursor = {};
        keyboard.layout = "gb";
        auth.allow_empty_password = config.modules.u2f.enable;
      };
    };

  };
}
