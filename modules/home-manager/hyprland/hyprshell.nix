{ ... }:

{
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
}
