{ inputs, pkgs, ... }:

{
  # Use overlay from flake
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  # Enable niri
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };

  imports = [
    # Import the nixos modules from flake
    inputs.niri.nixosModules.niri
    # Launch through tuigreet
    (import ./tuigreet.nix {
      inherit pkgs;
      successfulLoginCommand = "niri";
    })
    # TODO: Switch to noctalia-greeter when matured
    # (import ./noctalia-greeter.nix {
    #   inherit inputs pkgs;
    #   session = "niri";
    #   monitor = "eDP-1"; # TODO: Untie from work-specific monitor - make config val
    # })
  ];
}
