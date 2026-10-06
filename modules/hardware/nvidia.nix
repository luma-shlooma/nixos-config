{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.nvidia;
in
{
  # Options
  options.modules.nvidia.enable = mkEnableOption "Nvidia drivers";

  # Config
  config = mkIf cfg.enable {
    # Enable OpenGL
    hardware.graphics.enable = true;

    # Select GPU drivers
    services.xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };

    hardware.nvidia = {
      # Mode setting is required.
      modesetting.enable = true;
      # OPTIONAL : POWER MANAGEMENT OPTION - ENABLE IF CORRUPTION ON WAKE
      powerManagement.enable = false;
      # Fine-grained power management. Turns off GPU when not in use.
      powerManagement.finegrained = false;
      # Use the Nvidia open source kernel module.
      open = false;
      # Enable Nvidia settings menu,
      # accessible via 'nvidia-settings'.
      nvidiaSettings = true;
      # Driver version
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
