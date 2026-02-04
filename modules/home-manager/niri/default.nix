{ ... }:

{
  imports = builtins.map import [
    # niri config & bindings
    ./configuration.nix
    ./bindings.nix

    # walker launcher
    ../walker
  ];
}
