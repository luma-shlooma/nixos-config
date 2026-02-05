{ inputs, pkgs, ... }:

{
  # Install noctalia package from flake
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
