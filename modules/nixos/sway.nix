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

  # tuigreet
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --time --cmd sway";
        user = "haydn";
      };
    };
  };
}
