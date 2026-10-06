{ config, inputs, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.flatpak;
  # Functions to build package lists
  build = origin: appId: { origin = origin; appId = appId; };
  buildFlathub = build "flathub";
  buildFlathubBeta = build "flathub-beta";
in
{
  # Options
  options.modules.flatpak = {
    enable = mkEnableOption "Flatpak";
    packages = {
      flathub = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Packages to install from flathub.";
        example = "org.vinegarhq.Sober";
      };
      flathub-beta = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Packages to install from flathub-beta.";
        example = "com.stremio.Stremio";
      };
    };
  };

  # Import the nix-flatpak module
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # Config
  config = mkIf cfg.enable {

    # Enable the flatpak service
    services.flatpak = {
      enable = true;
      update.auto.enable = false;
      uninstallUnmanaged = true;
      # Add flathub-beta remotes
      remotes = lib.mkOptionDefault [{
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }];
      # Install packages from flathub and flathub-beta
      packages = [
        map buildFlathub cfg.packages.flathub
        map buildFlathubBeta cfg.packages.flathub-beta
      ];
    };
    
    services.flatpak.

    # Enable xdg
    config.modules.xdg.enable = true;

    # Maybe needed?
    security.rtkit.enable = true;

    # Fix for ssl handshake errors
    environment.systemPackages = [
      pkgs.p11-kit
    ];

  };
}
