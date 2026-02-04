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
  ];
}
