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
    # Monitor presets
    ./monitor-presets/home.nix
    # Themes
    ./theme/default.nix
  ];
}
