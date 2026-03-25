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
    protontricks
  ];
  # Required for protonup
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Xbox One gamepad driver
  # hardware.xpadneo.enable = true;
  # Attempted fix
  # services.udev.packages = [
  #   (pkgs.writeTextFile {
  #       name = "60-xpadneo";
  #       text = ''
  #           ACTION=="bind", SUBSYSTEM=="hid", DRIVER!="xpadneo", KERNEL=="0005:045E:*", KERNEL=="*:02FD.*|*:02E0.*|*:0B05.*|*:0B13.*|*:0B20.*|*:0B22.*", ATTR{driver/unbind}="%k", ATTR{[drivers/hid:xpadneo]bind}="%k"
  #           ACTION!="remove", DRIVERS=="xpadneo", SUBSYSTEM=="input", TAG+="uaccess"
  #       '';
  #       destination = "/etc/udev/rules.d/60-xpadneo.rules";
  #   })
  #   (pkgs.writeTextFile {
  #       name = "70-xpadneo-disable-hidraw";
  #       text = ''
  #           ACTION!="remove", DRIVERS=="xpadneo", SUBSYSTEM=="hidraw", MODE:="0000", TAG-="uaccess"
  #       '';
  #       destination = "/etc/udev/rules.d/70-xpadneo-disable-hidraw.rules";
  #   })
  # ];
}
