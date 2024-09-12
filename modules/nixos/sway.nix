{ pkgs, ... }:

{
  # Keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
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

  # Greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd sway";
        user = "haydn";
      };
    };
  };
}
