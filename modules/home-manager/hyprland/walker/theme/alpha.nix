# Controlled Theme
{ config, lib, ... }:

let
  colours = config.theme.colours;
in
lib.mkIf (config.theme.name == "alpha")
{
  programs.walker = {
    config.theme = "alpha";
    themes = {
      "alpha" = {
        # https://github.com/abenz1267/walker/blob/master/resources/themes/default/style.css
        style = ''
          @define-color window_bg_color #${colours.black};
          @define-color accent_bg_color #${colours.grey};
          @define-color theme_fg_color #${colours.white};
          @define-color error_bg_color #${colours.red};
          @define-color error_fg_color #${colours.black};
        '' + builtins.readFile ./alpha.css;
        # https://github.com/abenz1267/walker/tree/master/resources/themes/default
        # layout = {
        #   "layout" = ''
        #
        #   '';
        # };
      };
    };
  };
}
