{ inputs, ... }:

{
  # Import plasma-manager
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager    
  ];

  # Plasma config
  programs.plasma = {

    enable = true;
    
    workspace = {
      lookAndFeel = "org.kde.breezeDark.desktop";
      wallpaperPlainColor = "0,0,0,256";
    };

  };
}
