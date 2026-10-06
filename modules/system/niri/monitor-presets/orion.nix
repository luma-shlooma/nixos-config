{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  wm = config.settings.windowManager;
  preset = config.settings.hardware.monitorPreset;
  kanshi = config.modules.kanshi;
in
{
  # Config
  config = mkIf (wm.enable && !kanshi.enable && (wm.selected == "niri") && (preset == "orion")) {
    
    # The home-manager config
    home-manager.users.${user} = {

      # A replacement for kanshi if it isn't working
      programs.niri.settings.outputs = 
      let
        laptop = {
          criteria = "Chimei Innolux Corporation 0x143C Unknown";
          mode = {
            width = 1920;
            height = 1200;
            refresh = 60.003;
          };
        };
        benq = {
         left.criteria = "PNP(BNQ) BenQ EW3270U VAR00152019";
         right.criteria = "PNP(BNQ) BenQ EW3270U VAR00148019";
         mode = {
          width = 2560;
          height = 1440;
          refresh = 59.951;
         };
        };
      in
      {
        "${laptop.criteria}" = {
          mode = laptop.mode;
          scale = 1;
          position.x = 1600;
          position.y = 1440;
        };
        "${benq.left.criteria}" = {
          mode = benq.mode;
          scale = 1;
          position.x = 0;
          position.y = 0;
        };
        "${benq.right.criteria}" = {
          mode = benq.mode;
          scale = 1;
          position.x = 2560;
          position.y = 0;
        };
      };

    };

  };
}
