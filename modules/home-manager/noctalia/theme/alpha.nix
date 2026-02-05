# Controlled Theme
{ config, lib, ... }:

let
  # Theme colours
  # colours = config.theme.colours;
in
lib.mkIf (config.theme.name == "alpha")
{
  programs.noctalia-shell.settings = {
    general = {
      dimmerOpacity = 0.2;
      showScreenCorners = false;
      forceBlackScreenCorners = false;
      radiusRatio = 0.2;
      iRadiusRatio = 1;
      boxRadiusRatio = 1;
      screenRadiusRatio = 1;
      animationSpeed = 1.5;
      animationDisabled = false;
      enableShadows = false;
      shadowDirection = "bottom_right";
      shadowOffsetX = 2;
      shadowOffsetY = 3;
    };
    ui = {
      fontDefault = "JetBrainsMono Nerd Font";
      fontFixed = "JetBrainsMono Nerd Font";
      panelBackgroundOpacity = 0.93;
      boxBorderEnabled = false;
    };
    bar = {
      marginVertical = 4;
      marginHorizontal = 4;
      frameThickness = 8;
      frameRadius = 12;
      outerCorners = true;
    };
    wallpaper = {
      enabled = false;
      overviewEnabled = false;
    };
    colorSchemes = {
      useWallpaperColors = false;
      predefinedScheme = "Monochrome"; # Currently, this generates all colours
      darkMode = true;
      schedulingMode = "off";
      manualSunrise = "06:30";
      manualSunset = "18:30";
      generationMethod = "tonal-spot";
      monitorForColors = "";
    };
  };
}
