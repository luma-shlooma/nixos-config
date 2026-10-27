{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.firefox;

  # Format a bookmark
  mkBookmark = b-name: b-url: { name = b-name; url = b-url; };
  # Format an inner-folder of bookmarks
  mkFolder = f-name: f-list: { toolbar = false; name = f-name; bookmarks = f-list; };
in
{
  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      programs.firefox.profiles.default.bookmarks = {
        force = true;
        settings = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              (mkFolder "Nix Resources" [
                (mkBookmark "Packages" "https://search.nixos.org/packages?channel=unstable&type=options")
                (mkBookmark "Options" "https://search.nixos.org/options?channel=unstable&type=options")
                (mkBookmark "Home Manager" "https://home-manager-options.extranix.com/?query=&release=master")
                (mkBookmark "builtins & lib" "https://teu5us.github.io/nix-lib.html")
              ])
              (mkFolder "Tool Resources" [
                (mkBookmark "Bash" "https://quickref.me/bash.html")
                (mkBookmark "Golang Packages" "https://pkg.go.dev")
                (mkBookmark "Hyprland" "https://wiki.hypr.land/Configuring")
                (mkBookmark "Nixvim" "https://mattsturgeon.github.io/nixvim")
                (mkBookmark "Noctalia" "https://docs.noctalia.dev/noctalia")
                (mkBookmark "Pinta" "https://www.pinta-project.com/user-guide")
                (mkBookmark "Vim" "https://vim.rtorr.com")
                (mkBookmark "Yazi" "https://yazi-rs.github.io/docs/quick-start")
              ])
              (mkFolder "Web Tools" [
                (mkBookmark "Desmos" "https://www.desmos.com/calculator")
                (mkBookmark "Docker Hub" "https://hub.docker.com")
                (mkBookmark "Github" "https://github.com")
                (mkBookmark "Gmail" "https://mail.google.com")
                (mkBookmark "Google Drive" "https://drive.google.com/drive/my-drive")
                (mkBookmark "Litterbox" "https://litterbox.catbox.moe")
                (mkBookmark "Nerd Fonts" "https://nerdfonts.com")
                (mkBookmark "Regex101" "https://regex101.com")
              ])
              (mkFolder "Media" [
                (mkBookmark "IMDb" "https://imdb.com")
                (mkBookmark "Reddit" "https://reddit.com")
                (mkBookmark "Spotify" "https://open.spotify.com")
                (mkBookmark "Stremio" "https://web.stremio.com")
                (mkBookmark "Twitch" "https://twitch.tv")
                (mkBookmark "Youtube" "https://youtube.com")
              ])
              (mkFolder "Games" [
                (mkFolder "Wikis+" [
                  (mkBookmark "Arcane Odyssey" "https://roblox-arcane-odyssey.fandom.com/wiki/Arcane_Odyssey_Wiki")
                  (mkBookmark "Astroneer" "https://astroneer.wiki.gg")
                  (mkBookmark "Baldur's Gate 3" "https://bg3.wiki")
                  (mkBookmark "Deltarune" "https://deltarune.wiki")
                  (mkBookmark "Minecraft" "https://minecraft.wiki")
                  (mkBookmark "Peak" "https://peak.wiki.gg")
                  (mkBookmark "Satisfactory" "https://satisfactory.wiki.gg")
                  (mkBookmark "Silksong" "https://silksongwiki.com")
                  (mkBookmark "Terraria" "https://terraria.wiki.gg")
                  (mkBookmark "Vintage Story" "https://wiki.vintagestory.at")
                  (mkBookmark "Warframe Market" "https://warframe.market")
                  (mkBookmark "Warframe Overframe" "https://overframe.gg")
                  (mkBookmark "Warframe" "https://wiki.warframe.com")
                ])
                (mkFolder "Web Games" [
                  (mkBookmark "Neal.fun" "https://neal.fun")
                  (mkBookmark "Out of Context!" "https://www.outofcontext.party")
                  (mkBookmark "Powerscradle" "https://powerscadle.com")
                  (mkBookmark "What's a Mook?" "https://whatsamook.games")
                ])
                (mkBookmark "Board Game Geek" "https://boardgamegeek.com")
                (mkBookmark "Itch" "https://itch.io")
                (mkBookmark "Modrinth" "https://modrinth.com")
                (mkBookmark "Nexus" "https://www.nexusmods.com")
                (mkBookmark "Roll20" "https://app.roll20.net/editor/setcampaign/21560167")
              ])
              (mkFolder "Homelab" [
                (mkBookmark "Cloudflare" "https://dash.cloudflare.com")
                (mkBookmark "Dozzle" "http://dozzle.shlooma.net")
                (mkBookmark "Home Assistant" "http://homeassistant.lan:8123")
                (mkBookmark "Luci" "https://192.168.8.1:8443/cgi-bin/luci")
                (mkBookmark "Pi-hole" "http://pihole.shlooma.net/admin")
              ])
            ];
          }
        ];
      };

    };

  };
}
