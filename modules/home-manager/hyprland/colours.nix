# Colour palette for user-space customisation
{
  # From Alacritty default theme
  black   = "181818";
  red     = "AC4242";
  green   = "90A959";
  yellow  = "F4BF75";
  blue    = "6A9FB5";
  magenta = "AA759F";
  cyan    = "75B5AA";
  white   = "D8D8D8";
  # Grey is custom
  grey    = "545454";

  light = {
    black   = "2C2C2C"; # Original moved to light grey
    red     = "C55555";
    green   = "ACC474";
    yellow  = "FECA88";
    blue    = "82B8C8";
    magenta = "C28CB8";
    cyan    = "93D3C3";
    white   = "F8F8F8";
    grey    = "6B6B6B";
  };

  dark = {
    black   = "0F0F0F";
    red     = "712B2B";
    green   = "5F6F3A";
    yellow  = "A17E4D";
    blue    = "456877";
    magenta = "704D68";
    cyan    = "4D7770";
    white   = "8E8E8E";
    grey    = "404040";
  };

  true-black = "000000";

  # For hyprland rgb() and rgba() formats
  # Use hex format (as above) for code and alpha (just two characters)
  rgb = code: "rgb("+code+")";
  rgba = code: alpha: "rgba("+code+alpha+")";
}
