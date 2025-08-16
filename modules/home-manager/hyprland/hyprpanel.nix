{ pkgs, ... }:

let
  # Func to launch executable with pinned focus on screen
  focusedLaunch = executable: "hyprctl dispatch exec '[float; pin; stayfocused; size 50% 50%] alacritty -e ${executable}'";
  # Colours
  palette = import ./colours.nix;
  # Some standard patterns
  theme = {
    bkg = "#${palette.black}";
    border = "#${palette.grey}";
    text = "#${palette.white}";
    subtext = "#${palette.grey}";
    # Colours matching to utilities
    window = "#${palette.cyan}";
    clock = "#${palette.green}";
    media = "#${palette.yellow}";
    sound = "#${palette.magenta}";
    bluetooth = "#${palette.blue}";
    network = "#${palette.cyan}";
    notifications = "#${palette.red}";
  };
in
{
  # Autostart
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "hyprpanel"
    ];
  };

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
    settings = {
      # No wallpaper - used for colour sampling 
      wallpaper.enable = false;
      # Config for the display bar
      bar = {
        autoHide = "never";
        # Define which modules go where
        layouts = {
          "*" = {
            left = [
              "power"
              "workspaces"
              "windowtitle"
            ];
            middle = [
              "clock"
            ];
            right = [
              "media"
              "volume"
              "bluetooth"
              "network"
              "systray"
              "notifications"
            ];
          };
        };
        # Per-module config
        customModules = {
          power = {
            icon = "";
            middleClick = "hyprpanel toggleWindow settings-dialog";
            rightClick = "alacritty --working-directory /etc/nixos";
          };
          scrollSpeed = 5;
        };
        workspaces = {
          showAllActive = true;
          show_icons = false;
          show_numbered = false;
          showWsIcons = false;
        };
        windowtitle = {
          custom_title = true;
        };
        clock = {
          format = "%a %b %d  %H:%M";
          showIcon = true;
          showTime = true;
        };
        bluetooth = {
          label = false;
          rightClick = focusedLaunch "bluetuith";
        };
        volume = {
          middleClick = "";
          rightClick = focusedLaunch "pamixer";
        };
        network = {
          label = true;
          rightClick = focusedLaunch "nmtui";
          showWifiInfo = true;
          truncation_size = 10;
        };
        notifications = {
          hideCountWhenZero = true;
          show_total = true;
        };
      };
      # Menu settings
      menus = {
        transition = "none";
        clock = {
          time = {
            military = true;
            hideSeconds = false;
          };
          weather.enabled = false;
        };
        media = {
          displayTime = true;
          noMediaText = "No Media Currently Playing";
        };
      };
      # Notif settings
      notifications = {
        ignore = [
          "spotify"
        ];
        showActionsOnHover = true;
        timeout = 5000;
        autoDismiss = true;
      };
      # Theming for hyprpanel
      theme = {
        # Theming on the top bar
        bar = {
          background = theme.bkg;
          dropdownGap = "2.9em";
          enableShadow = false;
          floating = false;
          location = "top";
          opacity = 100;
          transparent = true;
          border = {
            color = theme.border;
            location = "none";
          };
          # All widgets on the bar
          buttons = {
            background = theme.bkg;
            borderColor = theme.border;
            enableBorders = false;
            icon = "#${palette.white}";
            icon_background = theme.bkg;
            monochrome = false;
            opacity = 100;
            padding_x = "0.7rem";
            radius = "0.2em";
            separator.margins = "0.15em";
            spacing = "0.25em";
            style = "default";
            text = theme.text;
            y_margins = "0.1em";
            # Module specific theming
            bluetooth = {
              background = theme.bkg;
              icon = theme.bluetooth;
              text = theme.bluetooth;
            };
            clock = {
              background = theme.bkg;
              enableBorder = false;
              icon = theme.clock;
              text = theme.clock;
            };
            media = {
              background = theme.bkg;
              icon = theme.media;
              text = theme.media;
            };
            modules = {
              power = {
                background = theme.bkg;
                icon = "#${palette.blue}";
              };
            };
            network = {
              background = theme.bkg;
              enableBorder = false;
              icon = theme.network;
              text = theme.network;
            };
            notifications = {
              background = theme.bkg;
              icon = theme.notifications;
              total = theme.text;
            };
            systray = {
              background = theme.bkg;
              customIcon = "#${palette.white}";
              enableBorder = false;
            };
            volume = {
              background = theme.bkg;
              enableBorder = false;
              icon = theme.sound;
              text = theme.sound;
            };
            windowtitle = {
              background = theme.bkg;
              enableBorder = false;
              icon = theme.window;
              text = theme.window;
            };
            workspaces = {
              active = "#${palette.white}";
              background = theme.bkg;
              enableBorder = false;
              hover = "#${palette.magenta}";
              occupied = "#${palette.grey}";
              pill = {
                active_width = "10.5em";
                height = "3.5em";
                width = "3.5em";
              };
              smartHighlight = false;
            };
          };
          # Theming for dropdown menus
          menus = {
            background = "#${palette.true-black}";
            card_radius = "0.3em";
            cards = theme.bkg;
            dimtext = theme.subtext;
            feinttext = theme.subtext;
            label = theme.subtext;
            monochrome = false;
            text = theme.text;
            border = {
              color = theme.border;
              radius = "0.7em";
              size = "0.15em";
            };
            buttons = {
              active = "#${palette.grey}";
              default = "#${palette.grey}";
              disabled = "#${palette.dark.black}";
              radius = "0.7em";
              text = "#${palette.black}";
            };
            check_radio_button = {
              active = "#${palette.white}";
              background = "#${palette.grey}";
            };
            dropdownmenu = {
              background = theme.bkg;
              divider = theme.border;
              text = theme.text;
            };
            iconbuttons = {
              active = "#${palette.grey}";
              passive = "#${palette.white}";
            };
            icons = {
              active = "#${palette.white}";
              passive = "#${palette.grey}";
            };
            listitems = {
              active = theme.text;
              passive = theme.subtext;
            };
            # Overlay menu for systray right-click
            popover = {
              background = theme.bkg;
              text = theme.text;
            };
            progressbar = {
              background = theme.bkg;
              foreground = "#${palette.grey}";
              radius = "0.1rem";
            };
            scroller = {
              radius = "0.7em";
              width = "0.25em";
            };
            slider = {
              background = theme.bkg;
              backgroundhover = "#${palette.dark.black}";
              primary = "#${palette.white}";
              progress_radius = "0.6rem";
              puck = "#${palette.white}";
              slider_radius = "0.6rem";
            };
            switch = {
              disabled = "#${palette.dark.black}";
              enabled = "#${palette.green}";
              puck = "#${palette.grey}";
              radius = "0.4em";
              slider_radius = "0.4em";
            };
            tooltip = {
              background = theme.bkg;
              radius = "0.1em";
              text = theme.subtext;
            };
            menu = {
              # Module specific
              bluetooth = {
                background.color = theme.bkg;
                border.color = theme.border;
                card.color = theme.bkg;
                iconbutton.active = theme.bluetooth;
                iconbutton.passive = theme.text;
                icons.active = theme.bluetooth;
                icons.passive = "#${palette.grey}";
                label.color = theme.bluetooth;
                listitems.active = theme.bluetooth;
                listitems.passive = theme.text;
                scroller.color = theme.bluetooth;
                switch.disabled = "#${palette.dark.black}";
                switch_divider = theme.border;
                switch.enabled = "#${palette.green}";
                switch.puck = "#${palette.grey}";
                text = theme.text;
              };
              clock = {
                background.color = theme.bkg;
                border.color = theme.border;
                calendar.contextdays = theme.subtext;
                calendar.currentday = "#${palette.cyan}";
                calendar.days = theme.text;
                calendar.paginator = "#${palette.magenta}";
                calendar.weekdays = "#${palette.cyan}";
                calendar.yearmonth = theme.clock;
                card.color = theme.bkg;
                text = theme.text;
                time.time = theme.text;
              };
              media = {
                album = theme.subtext;
                artist = theme.text;
                background.color = theme.bkg;
                border.color = theme.border;
                buttons.background = "#${palette.dark.grey}";
                buttons.enabled = "#${palette.grey}";
                buttons.inactive = "#${palette.black}";
                buttons.text = "#${palette.black}";
                card.color = theme.bkg;
                slider.background = "#${palette.dark.grey}";
                slider.backgroundhover = "#${palette.dark.grey}";
                slider.primary = "#${palette.white}";
                slider.puck = "#${palette.white}";
                song = theme.media;
                timestamp = theme.subtext;
              };
              network = {
                background.color = theme.bkg;
                border.color = theme.border;
                card.color = theme.bkg;
                iconbuttons.active = theme.network;
                iconbuttons.passive = theme.text;
                icons.active = theme.network;
                icons.passive = "#${palette.grey}";
                label.color = theme.network;
                listitems.active = theme.network;
                listitems.passive = theme.text;
                scroller.color = theme.network;
                switch.disabled = "#${palette.dark.black}";
                switch.enabled = "#${palette.green}";
                switch.puck = "#${palette.grey}";
                text = theme.text;
              };
              notifications = {
                background = theme.bkg;
                border = theme.border;
                card = theme.bkg;
                clear = theme.notifications;
                label = theme.notifications;
                no_notifications_label = theme.bkg;
                scrollbar.color = theme.notifications;
                switch.disabled = "#${palette.dark.black}";
                switch_divider = theme.border;
                switch.enabled = "#${palette.green}";
                switch.puck = "#${palette.grey}";
              };
              power = {
                background.color = theme.bkg;
                border.color = theme.border;
                buttons.logout.background = theme.bkg;
                buttons.logout.icon = "#${palette.green}";
                buttons.logout.icon_background = theme.bkg;
                buttons.logout.text = "#${palette.green}";
                buttons.restart.background = theme.bkg;
                buttons.restart.icon_background = theme.bkg;
                buttons.restart.icon = "#${palette.yellow}";
                buttons.restart.text = "#${palette.yellow}";
                buttons.shutdown.background = theme.bkg;
                buttons.shutdown.icon = "#${palette.red}";
                buttons.shutdown.icon_background = theme.bkg;
                buttons.shutdown.text = "#${palette.red}";
                buttons.sleep.background = theme.bkg;
                buttons.sleep.icon = "#${palette.blue}";
                buttons.sleep.icon_background = theme.bkg;
                buttons.sleep.text = "#${palette.blue}";
              };
              # Do not have a dashboard module, but power uses confirmation cards
              dashboard.powermenu.confirmation = {
                card = theme.bkg;
                background = theme.bkg;
                border = theme.border;
                label = theme.text;
                body = theme.border;
                confirm = "#${palette.green}";
                button_text = "#${palette.black}";
                deny = "#${palette.dark.grey}";
              };
              systray = {
                dropdownmenu.background = theme.bkg;
                dropdownmenu.divider = theme.border;
                dropdownmenu.text = theme.text;
              };
              volume = {
                audio_slider.background = theme.bkg;
                audio_slider.backgroundhover = "#${palette.dark.black}";
                audio_slider.primary = "#${palette.grey}";
                audio_slider.puck = theme.sound;
                background.color = theme.bkg;
                border.color = theme.border;
                card.color = theme.bkg;
                iconbutton.active = theme.sound;
                iconbutton.passive = theme.text;
                input_slider.background = theme.bkg;
                input_slider.backgroundhover = "#${palette.dark.black}";
                input_slider.primary = "#${palette.grey}";
                input_slider.puck = theme.sound;
                label.color = theme.sound;
                listitems.active = theme.sound;
                listitems.passive = theme.text;
                text = theme.text;
              };
            };
          };
        };
        font = {
          label = "JetBrainsMono Nerd Font Ultra-Bold";
          name = "JetBrainsMono Nerd Font";
          size = "1.0rem";
          weight = 300;
        };
        # Appearance of actual notifications
        notification = {
          actions.background = theme.bkg;
          actions.text = "#${palette.blue}";
          background = theme.bkg;
          border = theme.border;
          border_radius = "0.3em";
          close_button.background = theme.notifications;
          close_button.label = "#${palette.black}";
          enableShadow = false;
          label = theme.text;
          text = theme.subtext;
          time = theme.subtext;
        };
        # Appearance of the volume bar that appears when volume is changed
        osd = {
          bar_color = theme.sound;
          bar_container = "#${palette.true-black}";
          bar_empty_color = theme.bkg;
          border.size = "0em";
          duration = 3000;
          enable = true;
          icon = "#${palette.grey}";
          icon_container = "#${palette.true-black}";
          label = theme.sound;
          margins = "7px 7px 7px 7px";
          opacity = 100;
          orientation = "vertical";
          radius = "0.3em";
        };
      };
    };
  };
}
