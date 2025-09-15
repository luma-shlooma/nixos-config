# Themed Program
{ ... }:

{
  imports = [
    # Configuration
    ./configuration.nix
    # Available themes
    ./theme/alpha.nix
  ];
}
