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
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --cmd hyprland";
        user = "haydn";
      };
      # Following attributes to fix systemd clash
      Unit.After = "multi-user.target";
      Service = {
        Type = "idle";
        ExecStartPre = "kill -SIGRTMIN+21 1";
        ExecStopPost = "kill -SIGRTMIN+20 1";
      };
    };
  };
 
}
