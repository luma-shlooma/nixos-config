{ pkgs, lib, ... }:

let
  # Get custom palette
  palette = import ../../assets/colours.nix;
  # Options for custom lock-screen visuals
  lock_options = "--screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color ${palette.dark.white} --key-hl-color ${palette.dark.white} --line-color ${palette.dark.black} --inside-color ${palette.grey}88 --text-color ${palette.white} --separator-color ${palette.dark.black} --ring-ver-color ${palette.dark.white} --inside-ver-color ${palette.grey}88 --text-ver-color ${palette.white}";
  lock_options_quick = "${lock_options} --grace 0 --fade-in 0";
  lock_options_grace = "${lock_options} --grace 5 --fade-in 5";
in
{
  # Swaylock
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
 
  # Swayidle
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f ${lock_options_grace}"; }
      { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f ${lock_options_quick}"; }
    ];
  };

  # i3status for swaybar
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = "#${palette.green}";
      color_degraded = "#${palette.yellow}";
      color_bad = "#${palette.red}";
      interval = 1;
    };
  };

  # wofi launcher
  programs.wofi = {
    enable = true;
    #...
    settings = {
      prompt = "Launch: ";
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
      # Colours
      colors = {
        # Greyscale focused
        focused = {
          background  = "#${palette.light.grey}";
          border      = "#${palette.dark.white}";
          childBorder = "#${palette.light.grey}";
          indicator   = "#${palette.dark.white}";
          text        = "#${palette.light.white}";
        };
        # Orangey urgent
        urgent = {
          background  = "#${palette.yellow}";
          border      = "#${palette.dark.yellow}";
          childBorder = "#${palette.yellow}";
          indicator   = "#${palette.dark.yellow}";
          text        = "#${palette.dark.white}";
        };
        # Darker focused inactive
        focusedInactive = {
          background  = "#${palette.light.black}";
          border      = "#${palette.dark.grey}";
          childBorder = "#${palette.light.black}";
          indicator   = "#${palette.grey}";
          text        = "#${palette.dark.white}";
        };
        # Dark unfocused
        unfocused = {
          background  = "#${palette.black}";
          border      = "#${palette.light.black}";
          childBorder = "#${palette.black}";
          indicator   = "#${palette.light.black}";
          text        = "#${palette.dark.white}";
        };
      };
      # Sway Bar
      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            # Status
            background = "#${palette.black}";
            statusline = "#${palette.white}";
            separator  = "#${palette.light.grey}";
            # WS
            focusedWorkspace = {
              background = "#${palette.blue}";
              border     = "#${palette.dark.blue}";
              text       = "#${palette.black}";
            };
            urgentWorkspace = {
              background = "#${palette.magenta}";
              border     = "#${palette.dark.magenta}";
              text       = "#${palette.black}";
            };
            inactiveWorkspace = {
              background = "#${palette.light.black}";
              border     = "#${palette.dark.grey}";
              text       = "#${palette.dark.white}";
            };
          };
        }
      ];
    };
    # Extra
    extraConfig = ''
      # Black BG
      output * bg #${palette.dark.black} solid_color
    '';
  };  
}
