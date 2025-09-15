args @ { ... }:

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
   left.criteria = "BNQ BenQ EW3270U VAR00152019";
   right.criteria = "BNQ BenQ EW3270U VAR00148019";
   mode = {
    fast = "2560x1440@59.951Hz";
    nice = "3840x2160@59.996Hz";
   };
  };
in
{
  # Require the "work" host because of hardcoded monitors
  assertions =
  let
    assertLib = import ../../../lib/assertions ({module = "kanshi";}//args);
  in
  [ (assertLib.host "work") ];

  services.kanshi = {
    enable = true;
    settings = [

      # Just the laptop
      {
        profile.name = "undocked";
        profile.outputs = [
          laptop
        ];
      }

      # Laptop + widescreen
      {
        profile.name = "widescreen";
        profile.outputs = [
          laptop
          (widescreen // {
            position = "-3440,-240";
          })
        ];
      }

      # Orion 2 monitor setup
      {
        profile.name = "orion";
        profile.outputs = [
          (laptop // {
            position = "1600,1440";
          })
          (benq.left // {
            mode = benq.mode.fast;
            position = "0,0";
          })
          (benq.right // {
            mode = benq.mode.fast;
            position = "2560,0";
          })
        ];
        # Execute swaymsg commands to re-order workspaces
        profile.exec = [
          "/etc/nixos/scripts/fix-orion-screens.sh"
          # "swaymsg workspace 1; swaymsg move workspace to output \$(/etc/nixos/scripts/get-monitor.sh \"${laptop.criteria}\")"
          # "swaymsg workspace 2; swaymsg move workspace to output \$(/etc/nixos/scripts/get-monitor.sh \"${benq.left.criteria}\")"
          # "swaymsg workspace 3; swaymsg move workspace to output \$(/etc/nixos/scripts/get-monitor.sh \"${benq.right.criteria}\")"
        ];
      }

      # Orion, just left monitor
      {
        profile.name = "orion-left";
        profile.outputs = [
          laptop
          (benq.left // {
            mode = benq.mode.nice;
            scale = 1.25; # 5/4
            position = "-768,-1728"; # Above. 4/5 of -960,-2160
          })
        ];
      }

      # Orion, just right monitor
      {
        profile.name = "orion-right";
        profile.outputs = [
          laptop
          (benq.right // {
            mode = benq.mode.nice;
            scale = 1.25; # 5/4
            position = "-768,-1728"; # Above. 4/5 of -960,-2160
          })
        ];
      }
    ];
  };
}
