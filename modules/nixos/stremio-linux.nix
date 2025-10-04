# https://github.com/Stremio/stremio-linux-shell
{ lib, ... }:

{
  # Add flathub-beta to remotes
  services.flatpak.remotes = lib.mkOptionDefault [{
    name = "flathub-beta";
    location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  }];
  
  # Install stremio-linux-shell beta flatpak
  services.flatpak.packages = [
    { appId = "com.stremio.Stremio"; origin = "flathub-beta"; }
  ];
}
