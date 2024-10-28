{ ... }:

let
  laptop = {
    crit = "Chimei Innolux Corporation 0x143C Unknown";
    pref = "1920x1200@60.003Hz";
  };
  widescreen = {
    crit = "Dell Inc. DELL P3421W 7G4PJ53";
    pref = "3440x1440@59.973Hz";
  };
in
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = laptop.crit;
            mode = laptop.pref;
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = laptop.crit;
            position = "3440,240";
            mode = laptop.pref;
          }
          {
            criteria = widescreen.crit;
            position = "0,0";
            mode = widescreen.pref;
          }
        ];
      }
    ];
  };
}
