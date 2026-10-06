{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.arduino;
in
{
  # Options
  options.modules.arduino.enable = mkEnableOption "Arduino";

  # Config
  config = mkIf cfg.enable {

    # Install arduino
    environment.systemPackages = with pkgs; [
      arduino
      arduino-ide
      arduino-cli
    ];
    # Use appropriate nix-shell w/ python to launch and compile programs

  };
}
