{ ... }:

{
  # Then home-specific overrides
  programs.noctalia.settings = {
    # https://docs.noctalia.dev/v5/bar/
    bar = {
      main = {
        position = "top";
        start = [ "session" "control-center" "small-gap" "network" "bluetooth" "volume" "big-gap" "media" ];
        center = [ "workspaces" ];
        end = [ "audio_visualizer" "big-gap" "clock" "clipboard" "notifications" ];
      };
    };

    # https://docs.noctalia.dev/v5/configuration/shell/#osd
    osd = {
      position = "center_right";
      orientation = "vertical";
    };
  };
}
