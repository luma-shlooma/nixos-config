{ ... }:

let
  laptop = {
    desc = "Chimei Innolux Corporation 0x143C Unknown";
    pref = "1920x1200@60.003Hz";
  };
  widescreen = {
    desc = "Dell Inc. DELL P3421W 7G4PJ53";
    pref = "3440x1440@59.973Hz";
  };
in
{
  services.kanshi = {
    enable = true;
    profiles = {
      undocked.outputs = [
        {
          criteria = laptop.desc;
          mode = laptop.pref;
        }
      ];
      widescreen.outputs = [
        {
          criteria = laptop.desc;
          position = "3440,240";
          mode = laptop.pref;
        }
        {
          criteria = widescreen.desc;
          position = "0,0";
          mode = widescreen.pref;
        }
      ];
    };
  };
}
