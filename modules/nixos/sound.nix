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
    };
  };

  environment.systemPackages = with pkgs; [
    # cli tui tool for audio
    pulsemixer
  ];
}
