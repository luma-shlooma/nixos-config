{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Allow app query XDG
  xdg.portal.enable = true;

  # extraPackages
  environment.systemPackages = with pkgs; [
    grim          # Screenshots
    slurp         # Screenshots (select)
    wl-clipboard  # Copy paste
    mako          # Notifications
    dunst         # Notif daemon
    libnotify     # +
    networkmanagerapplet # Waybar nm applet
  ];

  environment.sessionVariables = {
    # Fix invisible cursor
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps
    NIXOS_OZONE_WL = "1";
    # Config dir
    XDG_CONFIG_HOME = "$HOME/.config";
  };


  # tuigreet
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --time --cmd hyprland";
        user = "haydn";
      };
    # Following 3 attributes to fix systemd clash
      Unit.After = "multi-user.target";
      Service.Type = "idle";
    };
    vt = 2;
  };
 
}
