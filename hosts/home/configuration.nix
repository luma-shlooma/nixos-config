# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
args @ { host, pkgs, inputs, ... }:

{
  # Make sure this is being used with the "home" host
  assertions = 
  let
    assertLib = import ../../lib/assertions ({module = "home/configuration";}//args);
  in
  [ (assertLib.host "home") ];

  imports = [
    # Hardware
    ../../hardware/pc.nix
    # Home Manager
    inputs.home-manager.nixosModules.default
    # NixOS Modules
    ../../modules/nixos/enable-flakes.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/time.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/thunar.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/ddcutil.nix
    # ../../modules/nixos/docker.nix
    ../../modules/nixos/pinta.nix
    ../../modules/nixos/vlc.nix
    ../../modules/nixos/arduino.nix
    ../../modules/nixos/discord.nix
    ../../modules/nixos/spotify.nix
    ../../modules/nixos/flatpak.nix
    # ../../modules/nixos/stremio.nix
    ../../modules/nixos/stremio-linux.nix
    # ../../modules/nixos/stremio-service.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/minecraft.nix
    ../../modules/nixos/vintage-story.nix
    ../../modules/nixos/utilities.nix
  ];

  # Desktop portal
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    windows = {
      "11" = {
        title = "Windows";
        efiDeviceHandle = "HD1b";
        sortKey = "z_windows"; # `z` to place last on list
      };
    };
    configurationLimit = 16;
    extraInstallCommands = ''
      ${pkgs.gnused}/bin/sed -i 's/^default.*/default a_windows/' /boot/loader/loader.conf
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;
  security.polkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit host inputs; };
    users = {
      "haydn" = import ./haydn.nix;
    };
  };

  # Nixos Host Variable 
  environment.sessionVariables = {
    NIXOS_HOST = "home";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
