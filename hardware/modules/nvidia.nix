{ config, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # Select GPU drivers
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  hardware.nvidia = {
    # Modesettiing is required.
    modesetting.enable = true;
    # OPTIONAL : POWER MANAGEMENT OPTION - ENABLE IF CORRUPTION ON WAKE
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module.
    open = false;
    # Enable Nvidia settings menu,
    # accessible via 'nvidia-settings'.
    nvidiaSettings = true;
    # Driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
