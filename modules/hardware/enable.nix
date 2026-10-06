{ config, lib, ... }:
with lib;
let
  # Hardware settings
  # form = config.settings.hardware.form;
  device = config.settings.hardware.device;
in
{
  # Enable hardware modules based on hardware settings
  config.modules = {

    # Enable fingerprint reader services on the t14
    fingerprint.enable = mkDefault (device == "thinkpad-t14");
    # Enable common keyboard settings unless explicitly disabled
    keyboard.enable = mkDefault true;
    # Enable keyboard remap on all but home pc (can configure on wooting)
    keyboard.remap.enable = mkDefault (device != "home-pc");
    # Enable Nvidia drivers on home pc
    nvidia.enable = mkDefault (device == "home-pc");

  };
}

