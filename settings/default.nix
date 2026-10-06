{ ... }:
{
  imports = [
    # Settings
    ./greeter.nix
    ./hardware.nix
    ./launcher.nix
    ./system.nix
    ./terminal.nix
    ./theme.nix
    ./window-manager.nix
    # Theme colours
    ./theme-colours/default.nix
  ];
}
