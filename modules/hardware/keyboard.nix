{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.keyboard;
in
{
  # Options
  options.modules.keyboard.enable = mkEnableOption "common keyboard settings";

  # Config
  config = mkIf cfg.enable {

    # NOTE: Generated on install

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "uk";

  };
}
