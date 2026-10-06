{ ... }:
{
  imports = [
    # Configuration
    ./bindings.nix
    ./configuration.nix
    ./hass.nix
    ./rules.nix
    ./screenshot.nix
    ./sound.nix
    ./start-up.nix
    # Monitor presets
    ./monitor-presets/home.nix
    # Themes
    ./theme/default.nix
  ];
}
