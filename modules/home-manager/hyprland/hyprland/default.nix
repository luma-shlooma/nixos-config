# Themed Program
{ ... }:

{
  imports = [
    # Configuration
    ./general.nix
    ./bindings.nix
    ./rules.nix
    ./monitors.nix
    ./screenshot.nix
    # Available themes
    ./theme/alpha.nix
  ];
}
