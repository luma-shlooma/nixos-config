{ ... }:
{
  imports = [
    # Configuration
    ./configuration.nix
    # Presets
    ./presets/desktop.nix
    ./presets/laptop.nix
    # Themes
    ./theme/default.nix
  ];
}
