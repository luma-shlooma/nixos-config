{ ... }:

{
  imports = builtins.map import [
    # niri config & bindings
    ./configuration.nix
    ./bindings.nix
    ./monitors.nix

    # walker launcher
    ../walker

    # available themes
    ./theme/alpha.nix
  ];
}
