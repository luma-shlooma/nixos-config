{ lib, ... }:

{
  # Then work-specific overrides
  programs.noctalia-shell.settings = {
    # Only apply to laptop screen
    bar.monitors = [ "eDP-1" ];
    osd.monitors = [ "eDP-1" ];
    notifications.monitors = [ "eDP-1" ];

    # Bar modules
    bar.widgets = {
      left = [
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
          id = "Spacer";
          width = 8;
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
          id = "Brightness";
          displayMode = "onhover";
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
          id = "Battery";
          deviceNativePath = "__default__";
          displayMode = "graphic";
          hideIfIdle = false;
          hideIfNotDetected = true;
          showNoctaliaPerformance = false;
          showPowerProfiles = false;
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
        {
          id = "NightLight";
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
        enabled = true;
        id = "brightness-card";
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
