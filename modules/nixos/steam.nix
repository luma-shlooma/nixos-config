{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    # "Using Steam Input on Wayland"
    extest.enable = true;

    # Compatible launcher for games with iffy resolution
    # Add 'gamescope %command%' to a game's general launch options
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  
  # Gamemode for performance
  # Add 'gamemoderun %command%' to a game's general launch options
  programs.gamemode.enable = true;

  # ProtonGE
  environment.systemPackages = with pkgs; [
    protonup-ng
  ];
  # Required for protonup
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Xbox One gamepad driver
  hardware.xpadneo.enable = true;
}
