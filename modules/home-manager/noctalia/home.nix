{ ... }:

{
  # Then home-specific overrides
  programs.noctalia-shell.settings = {
    # Top-sittng bar
    bar.density = "default";
    bar.position = "top";
    bar.backgroundOpacity = 0;

    # Notifs
    notifications.location = "top_right";
    notifications.sounds.enable = true;

    # OSD
    osd.location = "right";

    # Bar modules
    bar.widgets = {
      left = [
        {
          id = "Spacer";
          width = 12;
        }
        {
          id = "ControlCenter";
          colorizeDistroLogo = false;
          colorizeSystemIcon = "none";
          customIconPath = "";
          enableColorization = false;
          icon = "noctalia";
          useDistroLogo = true;
        }
        {
          id = "Network";
          displayMode = "onhover";
        }
        {
          id = "Buetooth";
          displayMode = "onhover";
        }
        {
          id = "Volume";
          displayMode = "onhover";
          middleClickCommand = "pwvucontrol || pavucontrol";
        }
        {
          id = "Spacer";
          width = 6;
        }
        {
          id = "MediaMini";
          compactMode = false;
          compactShowAlbumArt = true;
          compactShowVisualizer = false;
          hideMode = "hidden";
          hideWhenIdle = false;
          maxWidth = 400;
          panelShowAlbumArt = true;
          panelShowVisualizer = true;
          scrollingMode = "hover";
          showAlbumArt = false;
          showArtistFirst = false;
          showProgressRing = true;
          showVisualizer = false;
          useFixedWidth = false;
          visualizerType = "linear";
        }
      ];
      center = [
        {
          id = "Workspace";
          characterCount = 2;
          colorizeIcons = false;
          emptyColor = "secondary";
          enableScrollWheel = true;
          focusedColor = "primary";
          followFocusedScreen = false;
          groupedBorderOpacity = 1;
          hideUnoccupied = false;
          iconScale = 0.8;
          labelMode = "none";
          occupiedColor = "secondary";
          pillSize = 0.6;
          reverseScroll = false;
          showApplications = false;
          showBadge = true;
          showLabelsOnlyWhenOccupied = true;
          unfocusedIconsOpacity = 1;
        }
      ];
      right = [
        {
          id = "AudioVisualizer";
          colorName = "primary";
          hideWhenIdle = true;
          width = 400;
        }
        {
          id = "Spacer";
          width = 6;
        }
        {
          id = "Clock";
          clockColor = "none";
          customFont = "";
          formatHorizontal = "HH:mm";
          formatVertical = "HH mm";
          tooltipFormat = "HH:mm ddd, MMM dd";
          useCustomFont = false;
        }
        {
          id = "NotificationHistory";
          hideWhenZero = false;
          hideWhenZeroUnread = false;
          showUnreadBadge = true;
          unreadBadgeColor = "primary";
        }
        {
          id = "Spacer";
          width = 12;
        }
      ];
    };

    # Control center content
    shortcuts = {
      left = [
        {
          id = "Network";
        }
        {
          id = "WiFi";
        }
        {
          id = "Bluetooth";
        }
      ];
      right = [
        {
          id = "Notifications";
        }
        {
          id = "PowerProfile";
        }
        {
          id = "KeepAwake";
        }
      ];
    };
    cards = [
      {
        enabled = true;
        id = "profile-card";
      }
      {
        enabled = true;
        id = "shortcuts-card";
      }
      {
        enabled = true;
        id = "audio-card";
      }
      {
        enabled = false;
        id = "weather-card";
      }
      {
        enabled = true;
        id = "media-sysmon-card";
      }
    ];
  };
}
