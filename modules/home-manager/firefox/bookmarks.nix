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
            (mkBookmark "Home Manager" "https://home-manager-options.extranix.com")
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
            (mkBookmark "Gmail" "https://mail.google.com")
            (mkBookmark "Google Drive" "https://drive.google.com/drive/my-drive")
            (mkBookmark "Github" "https://github.com")
            (mkBookmark "Nerd Fonts" "https://nerdfonts.com")
            (mkBookmark "Regex101" "https://regex101.com")
            (mkBookmark "Desmos" "https://www.desmos.com/calculator")
          ])
          (mkFolder "Media" [
            (mkBookmark "Youtube" "https://youtube.com")
            (mkBookmark "Stremio" "https://web.stremio.com")
            (mkBookmark "Twitch" "https://twitch.tv")
            (mkBookmark "Reddit" "https://reddit.com")
          ])
          (mkFolder "Games" [
            (mkFolder "Wikis+" [
              (mkBookmark "Arcane Odyssey" "https://roblox-arcane-odyssey.fandom.com/wiki/Arcane_Odyssey_Wiki")
              (mkBookmark "Baldur's Gate 3" "https://bg3.wiki")
              (mkBookmark "Deltarune" "https://deltarune.wiki")
              (mkBookmark "Minecraft" "https://minecraft.wiki")
              (mkBookmark "Silksong Map" "https://game8.co/games/Hollow-Knight-Silksong/archives/547822#hl_1")
              (mkBookmark "Vintage Story" "https://wiki.vintagestory.at")
              (mkBookmark "Warframe" "https://wiki.warframe.com")
              (mkBookmark "Warframe Market" "https://warframe.market")
              (mkBookmark "Warframe Overframe" "https://overframe.gg")
            ])
            (mkBookmark "Roll20" "https://app.roll20.net/editor")
            (mkBookmark "Itch" "https://itch.io")
            (mkBookmark "What's a Mook?" "https://whatsamook.games")
            (mkBookmark "Out of Context!" "https://www.outofcontext.party")
            (mkBookmark "Neal.fun" "https://neal.fun")
            (mkBookmark "Powerscradle" "https://powerscadle.com")
            (mkBookmark "Board Game Geek" "https://boardgamegeek.com")
            (mkBookmark "Nexus" "https://www.nexusmods.com")
          ])
          (mkFolder "Homelab" [
            (mkBookmark "Luci" "https://192.168.8.1:8443/cgi-bin/luci")
            (mkBookmark "Dozzle" "http://dozzle.shlooma.net")
            (mkBookmark "Home Assistant" "http://homeassistant.lan:8123")
            (mkBookmark "Pi-hole" "http://pihole.shlooma.net/admin")
            (mkBookmark "Cloudflare" "https://dash.cloudflare.com")
          ])
        ];
      }
    ];
  };
}
