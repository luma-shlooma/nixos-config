{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Controlled by the shared window-manager settings
  cfg = config.settings.windowManager;
  terminal = config.settings.terminal.app;
  launcher = config.settings.launcher;
  noctalia = config.modules.noctalia;
  ha = config.modules.homeAssistant;
  # Lua generators
  bind = args: { _args = args; };
  mouse = { mouse = true; };
  click = { click = true; };
  lua = generators.mkLuaInLine;
  mkDsp = dsp_name: param: lua "hl.dsp.${dsp_name}(${builtins.toString param})";
  dsp = {
    # Dispatchers, using mostly defaults
    close = mkDsp "window.close" "";
    drag = mkDsp "window.drag" "";
    exec = cmd: mkDsp "exec_cmd" "\"${cmd}\"";
    float = mkDsp "window.float" "";
    focus_dir = dir: mkDsp "focus" "{ direction = \"${dir}\" }";
    focus_ws = ws: mkDsp "focus" "{ workspace = \"${builtins.toString ws}\" }";
    fullscreen = mkDsp "window.fullscreen" "";
    kill = mkDsp "window.kill" "";
    move_dir = dir: mkDsp "window.move" "{ direction = \"${dir}\", follow = \"false\" }";
    move_ws = ws: mkDsp "window.move" "{ workspace = \"${builtins.toString ws}\", follow = \"false\" }";
    pin = mkDsp "window.pin" "";
    resize = keepAsp: mkDsp "window.resize" "{ keep_aspect_ratio = \"${if keepAsp then "true" else "false"}\" }";
  };
in
{
  # Config
  config = mkIf (cfg.enable && (cfg.selected == "hyprland")) {
    
    # The home-manager config
    home-manager.users.${user} = {

      # Keybinds
      wayland.windowManager.hyprland = {
        settings = {
          # Keybindings - copy sway
          bind = builtins.map bind ([
            # Basic
            [ "SUPER + Return" (dsp.exec terminal.launch) ]
            [ "SUPER + F" dsp.fullscreen ]
            [ "SUPER + SHIFT + Q" dsp.close ] # Changed from kill to close...
            [ "SUPER + SHIFT + E" dsp.kill ]  # Changed from exit to kill...
            [ "SUPER + D" (dsp.exec launcher.launch) ]
            # Special - think scratchpad
            [ "SUPER + SHIFT + code:20" (dsp.move_ws "special:scratchpad") ] # the `-` key
            [ "SUPER + code:20" (mkDsp "workspace.toggle_special" "scratchpad") ]
            # Workspace - focus + move to
          ] ++ map (ws: [ "SUPER + ${ws}" (dsp.focus_ws ws) ]) (range 0 9)
            ++ map (ws: [ "SUPER + SHIFT + ${ws}" (dsp.move_ws ws) ]) (range 0 9)
            ++ [
            # Windows
            [ "SUPER + SHIFT + Space" dsp.float ]
            [ "SUPER + Up" (dsp.focus_dir "up") ]
            [ "SUPER + Down" (dsp.focus_dir "down") ]
            [ "SUPER + Left" (dsp.focus_dir "left") ]
            [ "SUPER + Right" (dsp.focus_dir "right") ]
            [ "SUPER + SHIFT + Up" (dsp.move_dir "up") ]
            [ "SUPER + SHIFT + Down" (dsp.move_dir "down") ]
            [ "SUPER + SHIFT + Left" (dsp.move_dir "left") ]
            [ "SUPER + SHIFT + Right" (dsp.move_dir "right") ]
          ] ++ optionals noctalia.enable [
            # Noctalia Session Menu
            [ "SUPER + Escape" (dsp.exec "noctalia msg panel-toggle session") ]
            # Do not have the following on the 60% keyboard, but is available through mouse gestures
            [ "XF86AudioRaiseVolume" (dsp.exec "noctalia msg volume-up 5") ]
            [ "XF86AudioLowerVolume" (dsp.exec "noctalia msg volume-down 5") ]
          ] ++ optionals ha.enable [
            # Home Assistant custom lamp bindings
            [ "SUPER + L" (dsp.exec ha.scripts.toggleLamp) ]
            [ "SUPER + SHIFT + L" (dsp.exec ha.scripts.toggleManual) ]
          ] ++ [
            # Mouse bindings
            # Drag window - SUPER + LMB + DRAG
            [ "SUPER + mouse:272" dsp.drag mouse ]
            # Resize window - SUPER + RMB + DRAG
            [ "SUPER + mouse:273" (dsp.resize false) mouse ]
            # Resize window (keep aspect ratio) - SUPER + SHIFT + RMB + DRAG
            [ "SUPER + SHIFT + mouse:273" (dsp.resize true) mouse ]
            # Toggle float - SUPER + RMB
            [ "SUPER + mouse:273" dsp.float click]
            # Pin window - SUPER + MMB
            [ "SUPER + mouse:274" dsp.pin click ]
          ]);
        };
      };

    };

  };
}
