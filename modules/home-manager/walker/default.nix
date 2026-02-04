# Themed Program
{ inputs, ... }:

{
  imports = [
    # home-manager module from flake
    inputs.walker.homeManagerModules.default
    # Configuration
    ./configuration.nix
    ./option.nix
    # Available themes
    ./theme/alpha.nix
  ];
}
