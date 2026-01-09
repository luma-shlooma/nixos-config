# Themed Program
{ ... }:

{
  imports = [
    # Configuration
    ./general.nix
    ./bindings.nix
    ./sound.nix
    ./rules.nix
    ./monitors.nix
    ./screenshot.nix
    ./hass.nix
    # Available themes
    ./theme/alpha.nix
  ];
}
