{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.minecraft;
in
{
  # Options
  options.modules.minecraft.enable = mkEnableOption "Minecraft";

  # Config
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      # This is broken for v1.19+
      #minecraft
      # Prism launcher preferred
      prismlauncher
      # FTB launcher as backup (some issues with some servers)
      ftb-app
    ];

  };
}
