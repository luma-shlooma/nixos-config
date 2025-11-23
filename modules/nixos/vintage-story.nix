{ pkgs, ... }:

{
  # Install Vintage Story
  environment.systemPackages = with pkgs; [
    vintagestory
  ];
  
  # Allow insecure dotnet stuff
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-7.0.20"
    "dotnet-runtime-7.0.20"
  ];
}
