{ inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      # Better Firefox
      extraConfig = (builtins.readFile ./betterfirefox.js);
      # Extensions
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        cookie-autodelete
        i-dont-care-about-cookies
        ublock-origin
        darkreader
        return-youtube-dislikes
        sponsorblock
      ];
      # Other Settings
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
  # Separate bookmarks file
  imports = [
    ./bookmarks.nix
  ];
}
