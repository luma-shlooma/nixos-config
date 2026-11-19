{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.u2f;
in
{
  # Options
  options.modules.u2f.enable = mkEnableOption "PAM U2F";

  # Config
  config = mkIf cfg.enable {

    # Enable u2f module
    security.pam.u2f.enable = true;

  };
}
