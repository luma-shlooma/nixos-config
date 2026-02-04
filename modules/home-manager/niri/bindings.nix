{ config, ... }:

{
  programs.niri.settings.binds = {
    # Exit niri (logout)
    "Mod+Shift+E".action.quit.skip-confirmation = false;
    # Spawners
    "Mod+Return".action.spawn = "alacritty";
    "Mod+D".action.spawn = "${config.apps.launcher.launch}";
    "Mod+Shift+Q".action.close-window = {};
    # Workspaces
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+0".action.focus-workspace = 0;
    "Mod+Shift+1".action.move-window-to-workspace = [ { focus = false; } 1 ];
    "Mod+Shift+2".action.move-window-to-workspace = [ { focus = false; } 2 ];
    "Mod+Shift+3".action.move-window-to-workspace = [ { focus = false; } 3 ];
    "Mod+Shift+4".action.move-window-to-workspace = [ { focus = false; } 4 ];
    "Mod+Shift+5".action.move-window-to-workspace = [ { focus = false; } 5 ];
    "Mod+Shift+6".action.move-window-to-workspace = [ { focus = false; } 6 ];
    "Mod+Shift+7".action.move-window-to-workspace = [ { focus = false; } 7 ];
    "Mod+Shift+8".action.move-window-to-workspace = [ { focus = false; } 8 ];
    "Mod+Shift+9".action.move-window-to-workspace = [ { focus = false; } 9 ];
    "Mod+Shift+0".action.move-window-to-workspace = [ { focus = false; } 0 ];
    # Window manipulation
    "Mod+Left" .action.focus-column-or-monitor-left = {};
    "Mod+Right".action.focus-column-or-monitor-right = {};
    "Mod+Up"   .action.focus-window-or-monitor-up = {};
    "Mod+Down" .action.focus-window-or-monitor-down = {};
    "Mod+Shift+Left" .action.swap-window-left = {};
    "Mod+Shift+Right".action.swap-window-right = {};
    "Mod+Shift+Up"   .action.move-window-up-or-to-workspace-up = {};
    "Mod+Shift+Down" .action.move-window-down-or-to-workspace-down = {};
    "Mod+Ctrl+Left" .action.move-column-left-or-to-monitor-left = {};
    "Mod+Ctrl+Right".action.move-column-right-or-to-monitor-right = {};
    "Mod+Ctrl+Up"   .action.move-column-to-workspace-up = {};
    "Mod+Ctrl+Down" .action.move-column-to-workspace-down = {};
    "Mod+Ctrl+Shift+Left" .action.move-workspace-to-monitor-left = {};
    "Mod+Ctrl+Shift+Right".action.move-workspace-to-monitor-right = {};
    "Mod+Ctrl+Shift+Up"   .action.move-workspace-to-monitor-up = {};
    "Mod+Ctrl+Shift+Down" .action.move-workspace-to-monitor-down = {};
    "Mod+F".action.fullscreen-window = {};
    "Mod+Shift+Space".action.toggle-window-floating = {};
    "Mod+Tab".action.toggle-overview = {};
    # Screenshots
    "Mod+S".action.screenshot-screen.show-pointer = true;
    "Mod+Ctrl+S".action.screenshot-window = {};
    "Mod+Shift+S".action.screenshot = {};
  };
}
