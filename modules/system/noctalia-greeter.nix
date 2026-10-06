{ config, inputs, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.settings.greeter;
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "noctalia-greeter")) {

    # NOTE: Likely outdated a bit...
    #       I see there is a services.displayManager.noctalia-greeter option now
    # NOTE: Also, doesn't use cfg.onBott
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];
    programs.noctalia-greeter = {
      enable = true;
      # Optional configuration
      greeter-args = "";
      settings = {
        session.default = "${cfg.session}";
        user.default = "${user}";
        # TODO: Provide monitor name
        # output.name = "${monitor}";
        keyboard.layout = "gb";
        cursor = {
          theme = "phinger-cursors-light";
          package = pkgs.phinger-cursors;
        };
        appearance = {
          scheme = "Synced";
          hide_logo = true;
        };
      };
    };

  };
}
