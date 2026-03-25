{ ... }:

{
  # Install Soundux
  services.flatpak.packages = [
    { appId = "io.github.Soundux"; origin = "flathub"; }
  ];
}
