{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    machine-id = builtins.readFile "/etc/machine-id";
    systemHardware =
      if machine-id == "fe889dcd8af841be9944a24ea4f635f1" then
        ./hardware/t14.nix
      else
        throw "Unregistered machine ID"

  in
  {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs;};
	modules = [
	  systemHardware
	  ./hosts/work/configuration.nix
	];
      };
    };
  };
}
