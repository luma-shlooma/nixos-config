# Unused
args @ { inputs, ... }:

{
  # UFINISHED
  assertions = 
  let
    assertLib = import ../../../lib/assertions ({module = "plamsa6";}//args);
  in
  [ assertLib.unfinished ];

  # Import plasma-manager
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager    
  ];

  # Plasma config
  programs.plasma = {

    enable = true;
    
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaperPlainColor = "0,0,0";
    };

  };
}
