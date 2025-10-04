{ inputs, pkgs, ... }:

{
  # Enable the flatpak service
  services.flatpak = {
    enable = true;
    update.auto.enable = false;
    uninstallUnmanaged = true;
  };

  # Import the nix-flatpak module
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./xdg.nix
  ];

  # Maybe needed?
  security.rtkit.enable = true;

  # Fix for ssl handshake errors
  environment.systemPackages = [
    pkgs.p11-kit
  ];
}
