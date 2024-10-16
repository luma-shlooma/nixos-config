# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports =
    [
      # Home Manager
      inputs.home-manager.nixosModules.default
      # NixOS modules
      ../../modules/nixos/enable-flakes.nix
      ../../modules/nixos/users.nix
      ../../modules/nixos/time.nix
      ../../modules/nixos/network.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/sway.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/docker.nix
      ../../modules/nixos/lxc.nix
      #../../modules/nixos/k3s.nix
      ../../modules/nixos/arduino.nix
      ../../modules/nixos/utilities.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  security.polkit.enable = true;

  # Home Manager
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "haydn" = import ./haydn.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Not spported by HM
    obsidian
    # Misc
    ueberzugpp
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  # Nixos Host Variable 
  environment.sessionVariables = {
    NIXOS_HOST = "work";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
