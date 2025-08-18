{ pkgs, ... }:

let
  yazi-wrapper = pkgs.writeShellScriptBin "launch-yazi" ''
    #!${pkgs.stdenv.shell}
    if [ "$#" -gt 0 ]; then
      # Pass arguments to yazi
      ${pkgs.alacritty}/bin/alacritty -e ${pkgs.yazi}/bin/yazi "$@"
    else
      # No args, default to open home dir
      ${pkgs.alacritty}/bin/alacritty -e ${pkgs.yazi}/bin/yazi ~
    fi
  '';
in
{
  # Yazi
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  # Yazi wrapper for default file browser
  
  # Install script
  home.packages = [
    yazi-wrapper
  ];

  # Create xdg entry
  xdg = {
    enable = true;
    desktopEntries."yazi-wrapper" = {
      name = "Yazi File Manager (wrapped)";
      exec = "launch-yazi %U";
      type = "Application";
      terminal = false;
      mimeType = [ "inode/directory" ];
      noDisplay = true;
    };
    # Set as default
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [
          "yazi-wrapper.desktop"
          "yazi.desktop"
        ];
      };
    };
  };


  # Alternative method
  # home.file.".local/share/applications/yazi-wrapper.desktop" = {
  #   text = ''
  #     [Desktop Entry]
  #     Name=Yazi Wrapper
  #     Exec=${yazi-wrapper}/bin/launch-yazi %f
  #     Type=Application
  #     Terminal=false
  #     MimeType=inode/directory
  #   '';
  # };

}
