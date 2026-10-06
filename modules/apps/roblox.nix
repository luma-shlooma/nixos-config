{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.roblox;
in
{
  # Options
  options.modules.roblox.enable = mkEnableOption "Roblox";

  # Config
  config = mkIf cfg.enable {

    # Install Sober via flatpak
    modules.flatpak = {
      enable = true;
      packages = [ "com.vinegarhq.Sober" ];
    };

  };
}
