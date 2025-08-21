{ pkgs, ... }:

{
  # Keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dmenu
      # Screenshots
      grim
      slurp
      # Clipboard
      wl-clipboard
      # Json query (used with swaymsg)
      jq
      # Backlight
      brightnessctl
      # Audio
      pamixer
    ];
  };

  imports = [
    (import ./tuigreet.nix {
      inherit pkgs;
      successfulLoginCommand = "sway";
    })
  ];
}
