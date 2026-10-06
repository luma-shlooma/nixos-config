{ ... }:
{
  # Import ALL modules, enabled later by `host/` or each other
  imports = [
    # Apps
    #$ ls apps/ | sed 's|^|./apps/|'
    ./apps/audacity.nix
    ./apps/discord.nix
    ./apps/firefox
    ./apps/flatpak.nix
    ./apps/libreoffice.nix
    ./apps/minecraft.nix
    ./apps/obs.nix
    ./apps/obsidian.nix
    ./apps/pinta.nix
    ./apps/roblox.nix
    ./apps/spotify.nix
    ./apps/steam.nix
    ./apps/stremio.nix
    ./apps/thunar.nix
    ./apps/vintage-story.nix
    ./apps/vlc.nix
    # Core
    #$ ls core/ | sed 's|^|./core/|'
    ./core/bash.nix
    ./core/flakes.nix
    ./core/network.nix
    ./core/time.nix
    ./core/users.nix
    ./core/utilities.nix
    # Hardware
    #$ ls hardware/ | sed 's|^|./hardware/|'
    ./hardware/enable.nix
    ./hardware/fingerprint.nix
    ./hardware/kanata.nix
    ./hardware/keyboard.nix
    ./hardware/nvidia.nix
    # System
    #$ ls system/ | sed 's|^|./system/|'
    ./system/bluetooth.nix
    ./system/home-manager.nix
    ./system/hyprland
    ./system/niri
    ./system/noctalia
    ./system/noctalia-greeter.nix
    ./system/power.nix
    ./system/sound.nix
    ./system/tuigreet.nix
    ./system/walker
    ./system/xdg.nix
    # Tools
    #$ ls tools/ | sed 's|^|./tools/|'
    ./tools/alacritty
    ./tools/amazon-q.nix
    ./tools/antigravity.nix
    ./tools/arduino.nix
    ./tools/ddcutil.nix
    ./tools/docker.nix
    ./tools/easyeffects.nix
    ./tools/homeassistant
    ./tools/k3s.nix
    ./tools/kanshi
    ./tools/logiops.nix
    ./tools/lxc.nix
    ./tools/mpris.nix
    ./tools/mullvad.nix
    ./tools/neovim
    ./tools/wine.nix
    ./tools/wireguard.nix
    ./tools/wireshark.nix
    ./tools/wootility.nix
    ./tools/yazi.nix
    ./tools/ydotool.nix
    ./tools/zsh
  ];
}
