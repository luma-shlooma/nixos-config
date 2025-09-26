# Config for 0.13.26
args @ { pkgs, ... }:

let
  mkAllDefault = import ../../../../lib/funcs/mkAllDefault.nix args;
in
{
  # Can only be used in conjunction with hyprland
  assertions =
  let
    assertLib = import ../../../../lib/assertions ({module = "hyprland/walker";}//args);
  in
  [ (assertLib.enabled "wayland.windowManager.hyprland.enable") ];

  # Walker config
  services.walker = {
    enable = true;
    systemd.enable = false;
    package = pkgs.walker;
    settings = mkAllDefault true {
      # General
      as_window = false;
      close_when_open = true;
      disable_click_to_close = false;
      # disabled = [];
      force_keyboard_focus = true;
      hotreload_theme = true;
      ignore_mouse = false;
      # locale = "";
      # monitor = "";
      terminal = "alacritty"; # TODO: Config option?
      # terminal_title_flag = "";
      # theme_location = [];
      # plugin_location = [];
      theme = "default";
      # theme_base = [];
      timeout = 0;
      # js_runtime = "";

      # General keybinds
      keys = {
        accept_typeahead = ["ctrl tab"];
        close = ["esc"];
        next = ["down" "tab"];
        previous = ["up"];
        remove_from_history = ["shift backspace"];
        resume_query = ["ctrl r"];
        toggle_exact_search = [];
        trigger_labels = "lalt";
        activation_modifiers = {
          keep_open = "shift";
          alternate = "alt";
        };
        ai = {
          clear_session = [];
          copy_last_response = [];
          resume_session = [];
          run_last_response = [];
        };
      };
      # Hook events
      events = {
        on_activate = "";
        on_selection = "";
        on_exit = "";
        on_launch = "";
        on_query_change = "";
      };
      # List config
      list = {
        cycle = false;
        dynamic_sub = true;
        keyboard_scroll_style = "emacs";
        max_entries = 0;
        show_initial_entries = true;
        single_click = true;
        visibility_threshold = 20;
        placeholder = "No Results";
      };
      # Search config
      search = {
        argument_delimiter = "#";
        delay = 0;
        resume_last_query = false;
        placeholder = "Search...";
      };
      # The 'jkl;asdf' labels on items
      activation_mode = {
        disabled = true;
        # labels = "jkl;asdf";
        # use_f_keys = false;
      };
      # Builtins
      "builtins" = {
        # AI
        ai.hidden = true;
        # Applications
        applications = {
          name = "applications";
          placeholder = "Applications";
          prioritize_new = true;
          hide_actions_with_empty_query = true;
          context_aware = true;
          refresh = true;
          show_sub_when_single = true;
          show_icon_when_single = true;
          show_generic = true;
          history = true;
          icon = "applications-other";
          actions = {
            enabled = true;
            hide_category = false;
            hide_without_query = true;
          };
        };
        # Bookmarks
        bookmarks.hidden = true;
        # Calculator
        calc.hidden = true;
        # Clipboard
        clipboard = {
          name = "clipboard";
          placeholder = "Clipboard";
          always_put_new_on_top = true;
          exec = "wl-copy";
          icon = "user-bookmarks";
          avoid_line_breaks = true;
          image_height = 300;
          max_entries = 10;
          switcher_only = true;
        };
        # Commands
        commands.hidden = true;
        # Custom commands
        custom_commands.hidden = true;
        # Hyprland keybinds
        hyprland_keybinds.hidden = true;
        # Dmenu
        dmenu = {
          hidden = true;
          name = "dmenu";
          placeholder = "Dmenu";
          switcher_only = true;
          show_icon_when_single = true;
        };
        # Emojis
        emojis = {
          name = "emojis";
          placeholder = "Emojis";
          exec = "wl-copy";
          icon = "face-smile";
          prefix = ".";
          switcher_only = true;
          history = true;
          typeahead = true;
          show_unqualified = false;
        };
        # Finder
        finder = {
          name = "finder";
          placeholder = "Finder";
          use_fd = false;
          fd_flags = "--ignore-vcs --type file --type directory";
          cmd_alt = "xdg-open \"$(dirname \"$HOME/%RESULT%\")\"";
          icon = "folder";
          prefix = "/";
          switcher_only = true;
          ignore_gitignore = true;
          refresh = true;
          concurrency = 8;
          show_icon_when_single = true;
          preview_images = false;
        };
        # Runner
        runner = {
          name = "runner";
          placeholder = "Runner";
          eager_loading = true;
          icon = "utilities-terminal";
          prefix = "$";
          switcher_only = true;
          typeahead = true;
          history = true;
          generic_entry = false;
          refresh = true;
          use_fd = false;
        };
        # SSH
        ssh.hidden = true;
        # Switcher
        switcher = {
          name = "switcher";
          placeholder = "Switcher";
          prefix = ";";
          switcher_only = true;
        };
        # Symbols
        symbols = {
          name = "symbols";
          placeholder = "Symbols";
          exec = "wl-copy '%RESULT%'";
          prefix = ",";
          switcher_only = true;
          history = true;
          typeahead = true;
        };
        # Translation
        translation.hidden = true;
        # Websearch
        websearch = {
          name = "websearch";
          placeholder = "Websearch";
          keep_selection = true;
          icon = "applications-internet";
          prefix = "@";
          entries = [
            {
              name = "DuckDuckGo";
              url = "https://duckduckgo.com/?q=%TERM%";
            }
          ];
        };
        # Windows
        windows.hidden = true;
        # xdph picker
        xdph_picker.hidden = true;
      };
    };
  };
}
