{ pkgs, ... }:

{
  # Get SDDM theme
  environment.systemPackages = [
    # KWallet
    pkgs.kdePackages.kwallet-pam
    # Themes
    #(pkgs.catppuccin-sddm.override {
    #  flavor = "mocha";
    #})
    #pkgs.sddm-sugar-dark
  ];
  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    #theme = "catppuccin-mocha";
    #package = pkgs.kdePackages.sddm;
  };
  # Remove plasma6 packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];
}
