{ ... }:

{
  # Then work-specific overrides
  programs.noctalia.settings = {
    # https://docs.noctalia.dev/v5/bar/
    bar = {
      main = {
        enabled = false;
        monitor.eDP-1 = {
          enabled = true;
          position = "bottom";
          start = [ "session" "control-center" "spacer" "network" "bluetooth" "volume" "brightness" ];
          center = [ "workspaces" ];
          end = [ "battery" "clock" ];
        };
      };
    };

    # https://docs.noctalia.dev/v5/configuration/shell/#osd
    osd = {
      position = "bottom_center";
      orientation = "horizontal";
    };
    
    # https://docs.noctalia.dev/v5/services/notifications/
    notification = {
      monitors = [ "eDP-1" ];
    };

    # TODO: Lockscreen on eDP-1 only?
  };
}
