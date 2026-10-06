{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.yazi;
in
{
  # Options
  options.modules.yazi.enable = mkEnableOption "Yazi";

  # Config
  config = mkIf cfg.enable {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Yazi
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
      };

      # Create xdg entry
      xdg = {
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
          defaultApplications = {
            "inode/directory" = [
              "thunar.desktop"  # Prefer thunar if installed
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

    };

  };
}
