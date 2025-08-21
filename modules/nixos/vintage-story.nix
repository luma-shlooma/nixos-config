{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vintagestory
  ];
  

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-7.0.20"
    "dotnet-runtime-7.0.20"
  ];
}
