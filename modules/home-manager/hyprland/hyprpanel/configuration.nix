args @ { pkgs, ... }:

let
  # Func to launch executable with pinned focus on screen
  focusedLaunch = executable: "hyprctl dispatch exec '[float; pin; stayfocused; size 50% 50%] alacritty -e ${executable}'";
in
{
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/hyprpanel";}//args);
  in
  [ (assertLib.enabled "wayland.windowManager.hyprland.enable") ];

  # Autostart - done by systemd intergration
  # wayland.windowManager.hyprland.settings = {
  #   "exec-once" = [
  #     "hyprpanel"
  #   ];
  # };

  # Icons that would otherwise be missing
  home.packages = with pkgs; [
    papirus-icon-theme
  ];
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  programs.hyprpanel = {
    enable = true;
    # Config that remains true across all themes
    settings = {
      # Displayed bar
      bar = {
        bluetooth.rightClick = focusedLaunch "bluetuith";
        volume.rightClick = focusedLaunch "pamixer";
        network.rightClick = focusedLaunch "nmtui";
      };
      # Notif settings
      notifications = {
        ignore = [
          "spotify"
        ];
        showActionsOnHover = true;
        timeout = 8000;
        autoDismiss = true;
      };
    };
    systemd.enable = true;
  };
}
