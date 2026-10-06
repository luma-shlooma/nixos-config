{ config, lib, ... }:
with lib;
let
  # Configured user
  user = config.settings.system.user;
  # Theme options
  theme = config.settings.theme.selected;
  # colours = config.settings.theme.colours;
  # This module's config options
  cfg = config.modules.alacritty;
in
{
  config = mkIf (cfg.enable && (theme == "default")) {
    
    # home-manager config theming
    home-manager.users.${user} = {

      # Alacritty theming
      programs.alacritty = {
        settings = {
          # NOTE: the following doesn't even set until I change scale.
          #       also, I kinda prefer the default anyway.
          # font = {
          #   normal = {
          #     family = "JetBrainsMono Nerd Font";
          #     style = "Medium";
          #   };
          #   size = 11;
          # };
        };
      };

    };

    # nmtui uses newt which requires the following for colour
    environment.sessionVariables = {
      NEWT_COLORS = ''
        root=lightgray,black
        border=lightgray,black
        window=lightgray,black
        shadow=black,black
        title=green,black
        button=lightgray,black
        actbutton=black,green
        checkbox=lightgray,black
        actcheckbox=black,green
        entry=lightgray,black
        label=lightgray,black
        listbox=lightgray,black
        actlistbox=lightgray,black
        textbox=gray,lightgray
        acttextbox=lightgray,gray
        helpline=lightgray,black
        roottext=gray,black
        emptyscale=,black
        fullscale=,black
        disentry=grey,black
        compactbutton=black,yellow
        sellistbox=lightgray,black
        actsellistbox=black,lightgray
      '';
    };


  };
}
