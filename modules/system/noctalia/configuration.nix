{ config, funcs, inputs, lib, pkgs, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # This module's config options
  cfg = config.modules.noctalia;
in
{
  # Options
  options.modules.noctalia = {
    enable = mkEnableOption "Noctalia Shell";
    preset = mkOption {
      type = types.nullOr (types.enum [ "desktop" "laptop" ]);
      default = null;
      description = "Which preset deviation in shell configuration to use, if any.";
    };
  };

  # Config
  config = mkIf cfg.enable {

    # Run on start-up
    settings.windowManager.onStartUp = [
      "noctalia"
    ];

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        settings = (funcs.mkAllDefault true {
          # https://docs.noctalia.dev/v5/configuration/shell/
          shell = {
            lang = "en";
            offline_mode = false;
            telemetry_enabled = false;
            setup_wizard_enabled = false;
            niri_overview_type_to_launch_enabled = false;
            polkit_agent = false;
            password_style = "default";
            avatar_path = "~/Pictures/avatar.png";
            settings_show_advanced = true;
            middle_click_opens_widget_settings = true;
            show_location = false;
            clipboard_enabled = true;
            clipboard_history_max_entries = 100;
            clipboard_confirm_clear_history = true;
            clipboard_auto_paste = "auto";
            clipboard_image_action_command = "";
            shared_gl_context = true;
            # Greeter settings
            greeter_sync = {
              auto_sync = true;
              privilege_command = "alacritty -e run0";
            };

            panel = {
              launcher_placement = "centered";
              clipboard_placement = "centered";
              control_center_placement = "attached";
              wallpaper_placement = "attached";
              session_placement = "attached";
              open_near_click_control_center = false;
              open_near_click_launcher = false;
              launcher_categories = true;
              launcher_show_icons = true;
              launcher_compact = false;
              open_near_click_clipboard = false;
              open_near_click_wallpaper = false;
              open_near_click_session = false;
            };

            mpris = {
              blacklist = [];
            };

            screenshot = {
              save_to_file = true;
              directory = "";
              filename_pattern = "screenshot_%Y%m%d_%H%M%S";
              copy_to_clipboard = true;
              freeze_screen = false;
              pipe_to_command = false;
              pipe_command = "";
            };
          };
          
          # https://docs.noctalia.dev/v5/bar/
          bar = {
            order = [ "main" ];

            main = {
              position = "top";
              enabled = true;
              auto_hide = false;
              reserve_space = true;
              layer = "top";
            };
          };

          # https://docs.noctalia.dev/v5/bar/widgets/
          widget = {
            small-gap = {
              type = "spacer";
              length = 12;
            };
            big-gap = {
              type = "spacer";
              length = 24;
            };
          };
          
          # https://docs.noctalia.dev/v5/desktop/widgets/
          desktop_widgets = {
            enabled = false;
          };
        });
      };

    };

    # Install noctalia package from flake
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
