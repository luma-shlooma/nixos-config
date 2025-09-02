{ inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      # Better Firefox
      extraConfig = (builtins.readFile ../../assets/confs/user.js);
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
      # Bookmarks
      bookmarks = {
        force = true;
        settings = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "Nix Resources";
                toolbar = false;
                bookmarks = [
                  {
                    name = "Packages";
                    url = "https://search.nixos.org/packages";
                    keyword = "packages";
                  }
                  {
                    name = "Home Manager";
                    url = "https://home-manager-options.extranix.com/release=master";
                    keyword = "home manager";
                  }
                  # Additional resources here
                  # ...
                ];
              }
              {
                name = "Tool Resources";
                toolbar = false;
                bookmarks = [
                  {
                    name = "Yazi";
                    url = "https://yazi-rs.github.io/docs/quick-start/";
                  }
                  {
                    name = "Vim";
                    url = "https://vim.rtorr.com/";
                  }
                  {
                    name = "Nixvim";
                    url = "https://mattsturgeon.github.io/nixvim/";
                  }
                  {
                    name = "Hyprland Wiki";
                    url = "https://wiki.hypr.land/Configuring/";
                  }
                ];
              }
              {
                name = "Web Tools";
                toolbar = false;
                bookmarks = [
                  {
                    name = "Gmail";
                    url = "https://mail.google.com/";
                  }
                  {
                    name = "Github";
                    url = "https://github.com/";
                  }
                  {
                    name = "Nerd Fonts";
                    url = "https://nerdfonts.com/";
                  }
                ];
              }
              {
                name = "Media";
                toolbar = false;
                bookmarks = [
                  {
                    name = "Youtube";
                    url = "https://youtube.com/";
                  }
                  {
                    name = "Twitch";
                    url = "https://twitch.tv/";
                  }
                  {
                    name = "Reddit";
                    url = "https://reddit.com/";
                  }
                ];
              }
              {
                name = "Games";
                toolbar = false;
                bookmarks = [
                  {
                    name = "Itch";
                    url = "https://itch.io/";
                  }
                  {
                    name = "Wikis+";
                    toolbar = false;
                    bookmarks = [
                      {
                        name = "Deltarune";
                        url = "https://deltarune.wiki/";
                      }
                      {
                        name = "Warframe";
                        url = "https://wiki.warframe.com/";
                      }
                      {
                        name = "Warframe Market";
                        url = "https://warframe.market/";
                      }
                      {
                        name = "Vintage Story";
                        url = "https://wiki.vintagestory.at";
                      }
                    ];
                  }
                ];
              }
              # Additional bookmark folders here
              # ...
            ];
          }
        ];
      };
      # Other Settings
      settings = {
        "extensions.autoDisableScopes" = 0;
        #"browser.download.dir" = "${config.home.homeDirectory}/downloads";
        #"browser.download.folderList" = 2;
      };
    };
  };
}
