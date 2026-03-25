{ pkgs, ... }:

{
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
        "10-disable-camera-mic" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  # Match the webcam mic
                  "node.name" = "~alsa_input.usb-046d_HD_Pro_Webcam_C920.*";
                }
              ];
              actions = {
                update-props = {
                  "node.disabled" = true;
                };
              };
            }
          ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # cli tui tool for audio
    pulsemixer
    playerctl
  ];
}
