# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ ... }:

{
  # Config settings
  settings = {
    # Greeter
    greeter = {
      enable = true;
      selected = "tuigreet";
      onBoot = true;
    };
    # Hardware
    hardware = {
      device = "thinkpad-t14";
      monitorPreset = "orion";
    };
    # Launcher
    launcher = {
      enable = true;
      selected = "walker";
    };
    # System
    system = {
      host = "nixos";
      user = "haydn";
    };
    # Terminal
    terminal = {
      app.selected = "alacritty";
      shell.selected = "zsh";
    };
    # Theme
    theme = {
      selected = "default";
    };
    # Window Manager
    windowManager = {
      enable = true;
      selected = "niri";
    };
  };
  # Config modules
  modules = {
    # Apps
    firefox.enable = true;
    libreoffice.enable = true;
    obsidian.enable = true;
    thunar.enable = true;
    vlc.enable = true;
    # System
    bluetooth.enable = true;
    homeManager.enable = true;
    noctalia.enable = true;
    power.enable = true;
    sound.enable = true;
    # Tools
    alacritty.enable = true;
    amazon-q.enable = true;
    antigravity.enable = true;
    docker.enable = true;
    lxc.enable = true;
    neovim.enable = true;
    wireshark.enable = true;
    yazi.enable = true;
  };

  # === Misc Config ===

  # Bootloader config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable polkit
  security.polkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
