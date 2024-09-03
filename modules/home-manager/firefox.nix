{ inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      # Better Firefox
      extraConfig = (builtins.readFile ../../assets/confs/user.js);
      # Extensions
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        cookie-autodelete
        i-dont-care-about-cookies
        ublock-origin
      ];
      # Bookmarks
      bookmarks = [
        {
          name = "Nix Resources";
          toolbar = true;
          bookmarks = [
            {
              name = "Packages";
              url = "https://search.nixos.org/packages";
            }
            {
              name = "Home Manager";
              url = "https://home-manager-options.extranix.com/release=master";
            }
          ];
        }
        {
          name = "Tool Resources";
          toolbar = true;
          bookmarks = [
            {
              name = "Yazi";
              url = "https://yazi-rs.github.io/docs/quick-start/";
            }
          ];
        }
      ];
      # Other Settings
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
