{ config, lib, ... }:
with lib;
let
  # Configured user
  user = config.settings.user;
  # Theme options
  theme = config.settings.theme.selected;
  colours = config.settings.theme.colours;
  # This module's config options
  cfg = config.settings.launcher;
in
{
  config = mkIf (cfg.enable && (cfg.selected == "walker") && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users."${user}" = {

      # Theme walker
      programs.walker = {
        config.theme = "def";
        themes = {
          "def" = {
            # https://github.com/abenz1267/walker/blob/master/resources/themes/default/style.css
            style = ''
              @define-color window_bg_color #${colours.black};
              @define-color accent_bg_color #${colours.grey};
              @define-color theme_fg_color #${colours.white};
              @define-color error_bg_color #${colours.red};
              @define-color error_fg_color #${colours.black};
            '' + builtins.readFile ./default.css;
            # https://github.com/abenz1267/walker/tree/master/resources/themes/default
            # layout = {
            #   "layout" = ''
            #
            #   '';
            # };
          };
        };
      };

    };

  };
}
