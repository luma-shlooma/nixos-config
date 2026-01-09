# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
  hex = code: "#${code}";
  # Some standard patterns
  theme = {
    bkg = hex colours.black;
    border = hex colours.grey;
    text = hex colours.white;
    subtext = hex colours.grey;
    # Colours matching to utilities
    window = hex colours.cyan;
    clock = hex colours.green;
    media = hex colours.yellow;
    sound = hex colours.magenta;
    bluetooth = hex colours.blue;
    network = hex colours.cyan;
    notifications = hex colours.red;
  };
in
lib.mkIf (config.theme.name == "alpha")
{
  programs.hyprpanel.settings = {
    # No wallpaper - used for colour sampling 
    wallpaper.enable = false;
    # Displayed bar
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
      };
      network = {
        label = true;
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
          icon = hex colours.white;
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
              icon = hex colours.blue;
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
            customIcon = hex colours.white;
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
            active = hex colours.white;
            background = theme.bkg;
            enableBorder = false;
            hover = hex colours.magenta;
            occupied = hex colours.grey;
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
          background = hex colours.true-black;
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
            active = hex colours.grey;
            default = hex colours.grey;
            disabled = hex colours.dark-black;
            radius = "0.7em";
            text = hex colours.black;
          };
          check_radio_button = {
            active = hex colours.white;
            background = hex colours.grey;
          };
          dropdownmenu = {
            background = theme.bkg;
            divider = theme.border;
            text = theme.text;
          };
          iconbuttons = {
            active = hex colours.grey;
            passive = hex colours.white;
          };
          icons = {
            active = hex colours.white;
            passive = hex colours.grey;
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
            foreground = hex colours.grey;
            radius = "0.1rem";
          };
          scroller = {
            radius = "0.7em";
            width = "0.25em";
          };
          slider = {
            background = theme.bkg;
            backgroundhover = hex colours.dark-black;
            primary = hex colours.white;
            progress_radius = "0.6rem";
            puck = hex colours.white;
            slider_radius = "0.6rem";
          };
          switch = {
            disabled = hex colours.dark-black;
            enabled = hex colours.green;
            puck = hex colours.grey;
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
              icons.passive = hex colours.grey;
              label.color = theme.bluetooth;
              listitems.active = theme.bluetooth;
              listitems.passive = theme.text;
              scroller.color = theme.bluetooth;
              switch.disabled = hex colours.dark-black;
              switch_divider = theme.border;
              switch.enabled = hex colours.green;
              switch.puck = hex colours.grey;
              text = theme.text;
            };
            clock = {
              background.color = theme.bkg;
              border.color = theme.border;
              calendar.contextdays = theme.subtext;
              calendar.currentday = hex colours.cyan;
              calendar.days = theme.text;
              calendar.paginator = hex colours.magenta;
              calendar.weekdays = hex colours.cyan;
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
              buttons.background = hex colours.dark-grey;
              buttons.enabled = hex colours.grey;
              buttons.inactive = hex colours.black;
              buttons.text = hex colours.black;
              card.color = theme.bkg;
              slider.background = hex colours.dark-grey;
              slider.backgroundhover = hex colours.dark-grey;
              slider.primary = hex colours.white;
              slider.puck = hex colours.white;
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
              icons.passive = hex colours.grey;
              label.color = theme.network;
              listitems.active = theme.network;
              listitems.passive = theme.text;
              scroller.color = theme.network;
              switch.disabled = hex colours.dark-black;
              switch.enabled = hex colours.green;
              switch.puck = hex colours.grey;
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
              switch.disabled = hex colours.dark-black;
              switch_divider = theme.border;
              switch.enabled = hex colours.green;
              switch.puck = hex colours.grey;
            };
            power = {
              background.color = theme.bkg;
              border.color = theme.border;
              buttons.logout.background = theme.bkg;
              buttons.logout.icon = hex colours.green;
              buttons.logout.icon_background = theme.bkg;
              buttons.logout.text = hex colours.green;
              buttons.restart.background = theme.bkg;
              buttons.restart.icon_background = theme.bkg;
              buttons.restart.icon = hex colours.yellow;
              buttons.restart.text = hex colours.yellow;
              buttons.shutdown.background = theme.bkg;
              buttons.shutdown.icon = hex colours.red;
              buttons.shutdown.icon_background = theme.bkg;
              buttons.shutdown.text = hex colours.red;
              buttons.sleep.background = theme.bkg;
              buttons.sleep.icon = hex colours.blue;
              buttons.sleep.icon_background = theme.bkg;
              buttons.sleep.text = hex colours.blue;
            };
            # Do not have a dashboard module, but power uses confirmation cards
            dashboard.powermenu.confirmation = {
              card = theme.bkg;
              background = theme.bkg;
              border = theme.border;
              label = theme.text;
              body = theme.border;
              confirm = hex colours.green;
              button_text = hex colours.black;
              deny = hex colours.dark-grey;
            };
            systray = {
              dropdownmenu.background = theme.bkg;
              dropdownmenu.divider = theme.border;
              dropdownmenu.text = theme.text;
            };
            volume = {
              audio_slider.background = theme.bkg;
              audio_slider.backgroundhover = hex colours.dark-black;
              audio_slider.primary = hex colours.grey;
              audio_slider.puck = theme.sound;
              background.color = theme.bkg;
              border.color = theme.border;
              card.color = theme.bkg;
              iconbutton.active = theme.sound;
              iconbutton.passive = theme.text;
              input_slider.background = theme.bkg;
              input_slider.backgroundhover = hex colours.dark-black;
              input_slider.primary = hex colours.grey;
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
        actions.text = hex colours.blue;
        background = theme.bkg;
        border = theme.border;
        border_radius = "0.3em";
        close_button.background = theme.notifications;
        close_button.label = hex colours.black;
        enableShadow = false;
        label = theme.text;
        text = theme.text;
        time = theme.subtext;
      };
      # Appearance of the volume bar that appears when volume is changed
      osd = {
        bar_color = theme.sound;
        bar_container = hex colours.true-black;
        bar_empty_color = theme.bkg;
        border.size = "0em";
        duration = 3000;
        enable = true;
        icon = hex colours.grey;
        icon_container = hex colours.true-black;
        label = theme.sound;
        margins = "7px 7px 7px 7px";
        opacity = 100;
        orientation = "vertical";
        radius = "0.3em";
      };
    };
  };
}
