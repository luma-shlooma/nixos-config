{ pkgs, ... }:

{
  # Install package
  # Separate nix file to only target work profile
  environment.systemPackages = with pkgs; [
    amazon-q-cli
  ];
}
