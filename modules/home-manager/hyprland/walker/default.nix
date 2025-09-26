# Themed Program
{ ... }:

{
  imports = [
    # Configuration
    ./configuration.nix
    ./option.nix
    # Available themes
    ./theme/alpha.nix
  ];
}
