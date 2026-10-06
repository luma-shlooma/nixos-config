{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.flakes;
in
{
  # Options
  options.modules.flakes.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable experimental flakes. This config uses flakes so it is unlikely this can be disabled.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {

    # Enable flakes.
    # TODO: The nix-command is here too - should separate out.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  };
}
