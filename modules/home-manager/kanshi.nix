{ ... }:

let
  laptop = {
    criteria = "Chimei Innolux Corporation 0x143C Unknown";
    position = "0,0";
    mode = "1920x1200@60.003Hz";
  };
  widescreen = {
    criteria = "Dell Inc. DELL P3421W 7G4PJ53";
    mode = "3440x1440@59.973Hz";
  };
  benq = {
   left = "BNQ BenQ EW3270U VAR00152019";
   right = "BNQ BenQ EW3270U VAR00148019";
   mode = {
    fast = "2560x1440@59.951Hz";
    nice = "3840x2160@60.000Hz";
   };
  };
in
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          laptop
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          laptop
          (widescreen // {
            position = "-3440,-240";
          })
        ];
      }
      {
        profile.name = "orion";
        profile.outputs = [
          laptop
          {
            criteria = benq.left;
            position = "-1280,-1152"; # Top Left. 4/5 of -1600,-1440
            mode = benq.mode.fast;
            scale = 1.25; # 5/4
          }
          {
            criteria = benq.right;
            position = "768,-1152"; # Top Right. 4/5 of 960,-1440
            mode = benq.mode.fast;
            scale = 1.25; # 5/4
          }
        ];
      }
      {
        profile.name = "orion-left";
        profile.outputs = [
          laptop
          {
            criteria = benq.left;
            position = "-768,-1728"; # Above. 4/5 of -960,-2160
            mode = benq.mode.nice;
            scale = 1.25; # 5/4
          }
        ];
      }
      {
        profile.name = "orion-right";
        profile.outputs = [
          laptop
          {
            criteria = benq.right;
            position = "-768,-1728"; # Above. 4/5 of -960,-2160
            mode = benq.mode.nice;
            scale = 1.25; # 5/4
          }
        ];
      }
    ];
  };
}
