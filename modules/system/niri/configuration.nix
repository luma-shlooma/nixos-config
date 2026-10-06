{ config, inputs, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
in
{

  # Import the nixos modules from flake
  imports = [
    inputs.niri.nixosModules.niri
  ];

  # Config
  config = mkIf (cfg.enable && (cfg.selected == "niri")) {

    # Use overlay from flake
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    # Enable niri
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };

    # Set session if greeter is enabled
    modules.greeter.session = "niri";

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users.${user} = {

      # Configure in home-manager
      programs.niri = {
        settings = {
          # Keybinds overlay
          hotkey-overlay = {
            hide-not-bound = true;
            skip-at-startup = true;
          };
          input = {
            # Mouse control - switch monitors but not scroll windows
            focus-follows-mouse = {
              enable = true;
            max-scroll-amount = "0%";
            };
            keyboard.xkb.layout = "gb";
            touchpad.scroll-factor = 0.25;
            power-key-handling.enable = false;
          };
          overview = {
            zoom = 0.5;
          };
          gestures.hot-corners.enable = false;
          window-rules = [

          ];
        };
      };

      ### CURSOR
      # This used to be in theme, but `imports` is not supported
      # Phisch Phinger theme
      imports = [
        inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
      ];
      # Hyprcursor
      programs.hyprcursor-phinger.enable = true;
      # XCursor backup when hyprcursor fails
      home.pointerCursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        x11.enable = true;
        gtk.enable = true;
      };
      programs.niri.settings.cursor = {
        theme = "phinger-cursors-light";
        size = 24;
      };
      ###

    };

  };
}
