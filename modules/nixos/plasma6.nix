{ ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    # TODO: SDDM theme
  };
  services.desktopManager.plasma6.enable = true;
}
