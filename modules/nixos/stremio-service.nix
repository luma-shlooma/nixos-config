{ ... }:

{
  # Install stremio-service
  services.flatpak.packages = [
    { appId = "com.stremio.Service"; origin = "flathub"; }
  ];
  
  # Will be best to move flatpak management down to home-manager
  home-manager.users."haydn".xdg.desktopEntries."stremio" = {
    name = "Stremio";
    exec = "firefox web.stremio.com";
    type = "Application";
    terminal = false;
  };
}
