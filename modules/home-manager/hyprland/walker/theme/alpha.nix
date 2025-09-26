# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
in
lib.mkIf (config.theme.name == "alpha")
{
  services.walker = {

    # settings = {
    #
    #   # Override the builtin icons with nerdfonts
    #   "builtins" = {
    #     # AI
    #     ai.icon = "";
    #     ai.name = "  AI";
    #     # Applications
    #     applications.icon = "";
    #     applications.name = "  Applications";
    #     # Bookmarks
    #     bookmarks.icon = "";
    #     bookmarks.name = "  Bookmarks";
    #     # Calculator
    #     calc.icon = "";
    #     calc.name = "  Calculator";
    #     # Clipboard
    #     clipboard.icon = "";
    #     clipboard.name = "  Clipboard";
    #     # Commands
    #     commands.icon = "";
    #     commands.name = "󰇘  Commands";
    #     # Custom commands
    #     custom_commands.icon = "";
    #     custom_commands.name = "󰇘  Custom Commands";
    #     # Hyprland keybinds
    #     hyprland_keybinds.icon = "";
    #     hyprland_keybinds.name = "  Hyprland Keybinds";
    #     # Dmenu
    #     dmenu.icon = "";
    #     dmenu.name = "󰍜  Dmenu";
    #     # Emojis
    #     emojis.icon = "";
    #     emojis.name = "  Emojis";
    #     # Finder
    #     finder.icon = "";
    #     finder.name = "  Files";
    #     # Runner
    #     runner.icon = "";
    #     runner.name = "  Runner";
    #     # SSH
    #     ssh.icon = "";
    #     ssh.name = "  SSH";
    #     # Switcher
    #     switcher.icon = "";
    #     switcher.name = "  Switcher";
    #     # Symbols
    #     symbols.icon = "";
    #     symbols.name = "  Symbols";
    #     # Translation
    #     translation.icon = "";
    #     translation.name = "󰗊  Translate";
    #     # Websearch
    #     websearch.icon = "";
    #     websearch.name = "󰖟  Search";
    #     # Windows
    #     windows.icon = "";
    #     windows.name = "  Windows";
    #     # xdph picker
    #     xdph_picker.icon = "";
    #     xdph_picker.name = "  XDPH Picker";
    #   };
    # };

    theme = {
      # The layout of walker
      layout.ui = {
        fullscreen = false;
        anchors = {
          bottom = true;
          left = true;
          right = true;
          top = true;
        };
        window = {
          h_align = "fill";
          v_align = "fill";
          box = {
            h_align = "center";
            v_align = "center";
            bar = {
              orientation = "horizontal";
              position = "end";
              entry = {
                h_align = "fill";
                h_expand = true;
                icon = {
                  h_align = "center";
                  h_expand = true;
                  pixel_size = 24;
                  theme = "";
                };
              };
            };
            scroll = {
              list = {
                marker_color = "#${colours.yellow}";
                max_height = 400;
                min_width = 250;
                max_width = 800;
                item = {
                  activation_label.hide = true;
                  # icon.hide = true;
                };
                margins = {
                  top = 8;
                };
              };
            };
            search = {
              prompt = {
                name = "prompt";
                icon = "";
                h_align = "center";
                v_align = "center";
              };
              input = {
                h_align = "fill";
                h_expand = true;
                icons = true;
              };
              clear.hide = true;
              spinner.hide = true;
            };
          };
        };
      };
      
      style = ''
        /* 
          Taken and adapted from
          https://github.com/basecamp/omarchy/blob/master/default/walker/themes/omarchy-default.css
        */
        @define-color text #${colours.white};
        @define-color base #${colours.black};
        @define-color border #${colours.grey};
        @define-color foreground #${colours.white};
        @define-color background #${colours.black};
        @define-color selected-text #${colours.green};
        @define-color selected-background #${colours.light-black};
        
        #window,
        #box,
        #search,
        #password,
        #input,
        #prompt,
        #clear,
        #typeahead,
        #list,
        child,
        scrollbar,
        slider,
        #item,
        #text,
        #label,
        #sub,
        #activationlabel {
          all: unset;
        }

        * {
          font-family: JetBrains Mono;
          font-size: 12px;
        }

        /* Window */
        #window {
          background: transparent;
          color: @text;
        }

        /* Main box container */
        #box {
          background: @base;
          padding: 20px;
          border: 2px solid @border;
          border-radius: 0px;
        }

        /* Search container */
        #search {
          background: @base;
          padding: 10px;
          margin-bottom: 0;
          border-bottom: 2px solid @border;
        }

        /* Hide prompt icon */
        #prompt {
          opacity: 0;
          min-width: 0;
          margin: 0;
        }

        /* Hide clear button */
        #clear {
          opacity: 0;
          min-width: 0;
        }

        /* Input field */
        #input {
          background: none;
          color: @text;
          padding: 0;
        }

        #input placeholder {
          opacity: 0.5;
          color: @text;
        }

        /* Hide typeahead */
        #typeahead {
          opacity: 0;
        }

        /* List */
        #list {
          background: transparent;
        }

        /* List items */
        child {
          padding: 0px 12px;
          background: transparent;
          border-radius: 0;
        }

        child:selected,
        child:hover {
          background: @selected-background;
        }

        /* Item layout */
        #item {
          padding: 0;
        }

        #item.active {
          font-style: italic;
        }

        /* Icon */
        #icon {
          margin-right: 6px;
          -gtk-icon-transform: scale(0.7);
        }

        /* Text */
        #text {
          color: @text;
          padding: 8px 0;
        }

        #label {
          font-weight: normal;
        }

        /* Selected state */
        child:selected #text,
        child:selected #label,
        child:hover #text,
        child:hover #label {
          color: @selected-text;
        }

        /* Hide sub text */
        #sub {
          opacity: 0;
          font-size: 0;
          min-height: 0;
        }

        /* Hide activation label */
        #activationlabel {
          opacity: 0;
          min-width: 0;
        }

        /* Scrollbar styling */
        scrollbar {
          opacity: 0;
        }

        /* Hide spinner */
        #spinner {
          opacity: 0;
        }

        /* Hide AI elements */
        #aiScroll,
        #aiList,
        .aiItem {
          opacity: 0;
          min-height: 0;
        }

        /* Bar entry (switcher) */
        #bar {
          opacity: 0;
          min-height: 0;
        }

        .barentry {
          opacity: 0;
        }

      '';
    };
  };
}
