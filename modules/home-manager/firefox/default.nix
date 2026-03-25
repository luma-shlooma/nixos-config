{ inputs, config, lib, ... }:

{
  imports = [
    inputs.betterfox.modules.homeManager.betterfox
    ./bookmarks.nix
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    # programs.firefox.configPath = ".mozilla/firefox";
    betterfox = {
      enable = true;
      profiles.default = {
        enableAllSections = true;
      };
    };
    profiles.default = {
      isDefault = true;
      # Extensions
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        cookie-autodelete
        istilldontcareaboutcookies
        ublock-origin
        darkreader
        return-youtube-dislikes
        sponsorblock
      ];
      # Other Settings
      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.formfill.enable" = false;
        "browser.link.open_external" = 2;
        "signon.rememberSignons" = false;
      };
      search.default = "ddg";
      search.privateDefault = "ddg";
    };
  };
  # Fix clobbering
  home.file."${config.programs.firefox.configPath}/default/search.json.mozlz4".force = lib.mkForce true;
}
