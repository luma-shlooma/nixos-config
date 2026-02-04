{ pkgs, lib, config, ... }:

let
  # Options for custom lock-screen visuals
  lock_options = config.theme.modules.swaylock.options;
  lock_options_quick = "${lock_options} --grace 0 --fade-in 0";
  lock_options_grace = "${lock_options} --grace 5 --fade-in 5";
in
{
  # Import swaylock theme option module
  imports = [
    ./swaylock-options.nix
  ];

  # Swaylock
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
 
  # Swayidle
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = "${pkgs.stdenv.hostPlatform.system}/bin/systemctl suspend";
        # resumeCommand = "${pkgs.swaylock-effects}/bin/swaylock -f ${lock_options_quick}";
      }
    ];
    events = {
      "after-resume" = "${pkgs.swaylock-effects}/bin/swaylock -f ${lock_options_quick}";
    };
  };

  # i3status for swaybar
  programs.i3status = {
    enable = true;
    general = {
      interval = 1;
    };
  };

  # wofi launcher
  programs.wofi = {
    enable = true;
    settings = {
      drun-print_command = true;
    };
  };

  # Sway
  wayland.windowManager.sway = 
  let
    mod = "Mod4";
    term = "alacritty";
    need_wrap = "nvim|yazi|htop|vim";
  in
  {
    enable = true;
    config = {
      modifier = mod;
      defaultWorkspace = "workspace number 1";
      terminal = term;
      # wofi menu with terminal wrapper
      menu = "${pkgs.wofi}/bin/wofi -S drun | xargs bash -c 'case \"$0\" in ${need_wrap}) echo \"${term} -e $0\";; *) echo \"$0\";; esac' | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      input = {
        # UK keyboard
        "*".xkb_layout = "gb";
        # Touchpad settings
        "type:touchpad" = {
          natural_scroll = "enabled";
          scroll_factor = "0.25";
          tap = "enabled";
        };
      };
      keybindings = lib.mkOptionDefault {
        # Move Workspaces
        "${mod}+Control+Shift+Right" = "exec swaymsg move workspace to output right";
        "${mod}+Control+Shift+Left"  = "exec swyamsg move workspace to output left";
        "${mod}+Control+Shift+Down"  = "exec swaymsg move workspace to output down";
        "${mod}+Control+Shift+Up"    = "exec swaymsg move workspace to output up";
        # Lockscreen
        "${mod}+grave" = "exec ${pkgs.swaylock-effects}/bin/swaylock ${lock_options_grace}";
        # Screenshots - All | Selection | Monitor
        "Shift+Print"         = "exec grim - | wl-copy";
        "Shift+Alt+Print"     = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Shift+Control+Print" = "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy";
        # Brightness
        "XF86MonBrightnessDown" = "exec brightnessctl set 5-%";
        "XF86MonBrightnessUp"   = "exec brightnessctl set +5%";
        # Volume
        "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
        "XF86AudioRaiseVolume" = "exec pamixer --increase 5";
        "XF86AudioMute"        = "exec pamixer --toggle-mute";
      };
    };
  };  
}
