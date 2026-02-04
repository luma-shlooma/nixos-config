{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  # extraPackages
  environment.systemPackages = with pkgs; [
    hyprpicker    # Colour picker
    wl-clipboard  # Copy paste
    libnotify     # Send notifs
  ];

  environment.sessionVariables = {
    # Fix invisible cursor
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps
    NIXOS_OZONE_WL = "1";
    # Config dir
    XDG_CONFIG_HOME = "$HOME/.config";
  };


  # Launch through tuigreet
  imports = [
    (import ./tuigreet.nix {
      inherit pkgs;
      successfulLoginCommand = "start-hyprland";
      initialPrompt = false;
    })
  ];
}
