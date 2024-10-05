# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:


{
  imports = [
    # Home Manager
    inputs.home-manager.nixosModules.default
    # NixOS Modules
    ../../modules/nixos/enable-flakes.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/network.nix
    ../../modules/nixos/time.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/arduino.nix
    ../../modules/nixos/utilities.nix
  ];

  # Desktop portal
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
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
    extraSpecialArgs = { inherit inputs; };
    users = {
      "haydn" = import ./haydn.nix;
    };
  };

  # pkgs
  environment.systemPackages = with pkgs; [
    # ...
  ];
  
  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  # Nixos Host Variable 
  environment.sessionVariables = {
    NIXOS_HOST = "home";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
