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
    # Reusable hardware config
    commonHardware = hostModule: {
      imports = [
        "${self}/hardware-configuration.nix"
	hostModule
      ];
    };
  in
  {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs;};
	modules = [ commonHardware ./hosts/work/configuration.nix ];
      };
    };
  };
}
