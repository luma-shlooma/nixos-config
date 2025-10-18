{ ... }:

let
  # Format a bookmark
  mkBookmark = b-name: b-url: { name = b-name; url = b-url; };
  # Format an inner-folder of bookmarks
  mkFolder = f-name: f-list: { toolbar = false; name = f-name; bookmarks = f-list; };
in
{

  programs.firefox.profiles.default.bookmarks = {
    force = true;
    settings = [
      {
        name = "Toolbar";
        toolbar = true;
        bookmarks = [
          (mkFolder "Nix Resources" [
            (mkBookmark "Packages" "https://search.nixos.org/packages")
            (mkBookmark "Home Manager" "https://home-manager-options.extranix.com/release=master")
            (mkBookmark "builtins & lib" "https://teu5us.github.io/nix-lib.html")
          ])
          (mkFolder "Tool Resources" [
            (mkBookmark "Bash" "https://quickref.me/bash.html")
            (mkBookmark "Golang Packages" "https://pkg.go.dev")
            (mkBookmark "Yazi" "https://yazi-rs.github.io/docs/quick-start")
            (mkBookmark "Vim" "https://vim.rtorr.com")
            (mkBookmark "Nixvim" "https://mattsturgeon.github.io/nixvim")
            (mkBookmark "Hyprland Wiki" "https://wiki.hypr.land/Configuring")
            (mkBookmark "Pinta" "https://www.pinta-project.com/user-guide")
          ])
          (mkFolder "Web Tools" [
            (mkBookmark "Home Assistant" "http://homeassistant:8123")
            (mkBookmark "Gmail" "https://mail.google.com")
            (mkBookmark "Github" "https://github.com")
            (mkBookmark "Nerd Fonts" "https://nerdfonts.com")
            (mkBookmark "Regex101" "https://regex101.com")
          ])
          (mkFolder "Media" [
            (mkBookmark "Youtube" "https://youtube.com")
            (mkBookmark "Stremio" "https://web.stremio.com")
            (mkBookmark "Twitch" "https://twitch.tv")
            (mkBookmark "Reddit" "https://reddit.com")
          ])
          (mkFolder "Games" [
            (mkFolder "Wikis+" [
              (mkBookmark "Deltarune" "https://deltarune.wiki")
              (mkBookmark "Warframe" "https://wiki.warframe.com")
              (mkBookmark "Warframe Market" "https://warframe.market")
              (mkBookmark "Vintage Story" "https://wiki.vintagestory.at")
              (mkBookmark "Silksong Map" "https://game8.co/games/Hollow-Knight-Silksong/archives/547822#hl_1")
            ])
            (mkBookmark "Itch" "https://itch.io")
            (mkBookmark "What's a Mook?" "https://whatsamook.games")
            (mkBookmark "Out of Context!" "https://www.outofcontext.party")
            (mkBookmark "Neal.fun" "https://neal.fun")
          ])
        ];
      }
    ];
  };
}
