{ config, lib, pkgs, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.sound;
in
{
  # Options
  options.modules.sound.enable = mkEnableOption "Sound";

  # Config
  config = mkIf cfg.enable {

    security.rtkit.enable = true;
    services = {
      # Enable sound with pipewire.
      # pulseaudio.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
        wireplumber.extraConfig = {
          # Small rule to disable a webcam mic
          "10-disable-camera-mic"."monitor.alsa.rules" = [
            {
              # Match the webcam mic
              matches = [ { "node.name" = "~alsa_input.usb-046d_HD_Pro_Webcam_C920.*"; } ];
              # Disable it
              actions.update-props."node.disabled" = true;
            }
          ];
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # cli tui tool for audio
      pulsemixer
      playerctl
      coppwr
    ];

  };
}
