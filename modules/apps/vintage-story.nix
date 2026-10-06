{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.vintageStory;
in
{
  # Options
  options.modules.vintageStory.enable = mkEnableOption "Vintage Story";

  # Config
  config = mkIf cfg.enable {

    # Install Vintage Story
    environment.systemPackages = with pkgs; [
      vintagestory
    ];
    
    # Allow insecure dotnet stuff
    nixpkgs.config.permittedInsecurePackages = [
      "dotnet-runtime-wrapped-7.0.20"
      "dotnet-runtime-7.0.20"
    ];

  };
}
