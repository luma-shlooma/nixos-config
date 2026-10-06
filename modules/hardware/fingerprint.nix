{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.fingerprint;
in
{
  # Options
  options.modules.fingerprint.enable = mkEnableOption "fingerprint reader service";

  # Config
  config = mkIf cfg.enable {
    # Setup fingerprint scanner
    services.fprintd.enable = true;
    services.fprintd.tod.enable = true;
    services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix-550a;
  };
}
