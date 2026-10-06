# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:

{
  # Config settings
  settings = {
    # Greeter
    greeter = {
      enable = true;
      selected = "tuigreet";
      onBoot = false;
    };
    # Hardware
    hardware = {
      device = "home-pc";
      monitorPreset = "home";
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
      selected = "hyprland";
    };
  };
  # Config modules
  modules = {
    # Apps
    audacity.enable = true;
    discord.enable = true;
    firefox.enable = true;
    flatpak.enable = true;
    libreoffice.enable = true;
    minecraft.enable = true;
    obs.enable = true;
    obsidian.enable = true;
    pinta.enable = true;
    roblox.enable = true;
    spotify.enable = true;
    steam.enable = true;
    stremio.enable = true;
    thunar.enable = true;
    vintage-story.enable = true;
    vlc.enable = true;
    # System
    bluetooth.enable = true;
    noctalia.enable = true;
    sound.enable = true;
    # Tools
    antigravity.enable = true;
    docker.enable = true;
    easyeffects.enable = true;
    homeassistant.enable = true;
    logiops.enable = true;
    mpris.enable = true;
    neovim.enable = true;
    wine.enable = true;
    wootility.enable = true;
    yazi.enable = true;
  };

  # === Misc Config ===

  # Bootloader config
  boot.loader.systemd-boot = {
    enable = true;
    efi.canTouchEfiVariables = true;
    # TODO: Modularise?
    editor = false;
    # windows = {
    #   "11" = {
    #     title = "Windows";
    #     efiDeviceHandle = "HD1b";
    #     sortKey = "z_windows"; # `z` to place last on list
    #   };
    # };
    configurationLimit = 16;
    extraInstallCommands = ''
      ${pkgs.gnused}/bin/sed -i 's/^default.*/default a_windows/' /boot/loader/loader.conf
    '';
  };

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
