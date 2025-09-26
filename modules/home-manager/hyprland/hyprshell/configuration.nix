# THIS IS NOT BEING USED
# ROFI IS USED AS A LAUNCHER INSTEAD
# STILL NEED TO SEPARATE THEME CONFIGURATION
args @ { ... }:

{
  # UNFINISHED
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/hyprshell";}//args);
  in
  [
    assertLib.unfinished
    (assertLib.enabled "wayland.windowManager.hyprland.enable")
  ];

  # TODO: If every picked up again, use config launcher options

  services.hyprshell = {
    enable = true;

    settings = {
      layerrules = true;
      kill_bind = "ctrl+shift+alt, h";
      version = 1;

      windows = {
        scale = 8.5;
        items_per_row = 5;

        overview = {
          strip_html_from_workspace_title = true;
          key = "Tab";
          modifier = "super";
          filter_by = [];
          hide_filtered = false;

          launcher = {
            default_terminal = "alacritty";
            launch_modifier = "ctrl";
            width = 650;
            max_items = 5;
            show_when_empty = true;
            animate_launch_ms = 250;

            plugins = {
              applications = {
                run_cache_weeks = 4;
                show_execs = true;
                show_actions_submenu = false;
              };
              websearch.engines = [
                {
                  url = "https://duckduckgo.com/?q={}";
                  name = "DuckDuckGo";
                  key = "d";
                }
                {
                  url = "https://en.wikipedia.org/wiki/Special:Search?search={}";
                  name = "Wikipedia";
                  key = "w";
                }
                {
                  url = "https://www.youtube.com/results?search_query={}";
                  name = "YouTube";
                  key = "y";
                }
                {

                  url = "https://www.reddit.com/search?q={}";
                  name = "Reddit";
                  key = "r";
                }
              ];
            };
          };
        };
        switch = {
          modifier = "alt";
          filter_by = [];
          show_workspaces = true;
        };
      };
    };
    
    style = ''

    '';
  };

  wayland.windowManager.hyprland.settings.bind = [
    # Hyprshell launcher
    # Binds SUPER + D to the required SUPER + TAB binding from hyprshell using ydotool
    # Configuration will therefore have to import ydotool.nix
    # Wev identifies SUPER + TAB as codes 23 + 133, but ydotool seems to want different codes
    # BROKEN, cannot get this to work, gunna stick with familiar keybind
    "SUPER, d, exec, ydotool key 125:1 15:1 15:0 125:0"
  ];
}
