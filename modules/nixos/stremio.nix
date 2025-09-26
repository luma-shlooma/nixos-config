{ pkgs, ... }:

{
  # Recently, qt5 has been flagged as unmaintained and insecure
  # NixOS now requires the following to suppress the error
  # Hopefully qt6 is used soon or the linux-shell is developed further
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  environment.systemPackages = with pkgs; [
    stremio
  ];
}
