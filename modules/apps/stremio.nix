{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.stremio;
in
{
  # Options
  options.modules.stremio.enable = mkEnableOption "Stremio";

  # Config
  config = mkIf cfg.enable {

    # https://github.com/Stremio/stremio-linux-shell

    # Install Stremio + service via flatpak
    modules.flatpak = {
      enable = true;
      packages.flathub = [ "com.stremio.Service" ];
      packages.flathub-beta = [ "com.stremio.Stremio" ];
    };

  };
}
