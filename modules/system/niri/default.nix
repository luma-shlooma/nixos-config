{ ... }:

{
  imports = [
    # Configuration
    ./bindings.nix
    ./configuration.nix
    ./rules.nix
    ./start-up.nix
    # Monitor presets
    ./monitor-presets/orion.nix
    # Themes
    ./theme/default.nix
  ];
}
