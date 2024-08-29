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

    includeHardware = hostModule: {
      imports = [
        ./hardware/select.nix
	config.selectedHardware
        hostModule
      ];
    };
  in
  {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
	specialArgs = {inherit inputs;};
	modules = [ includeHardware ./hosts/work/configuration.nix ];
      };
    };
  };
}
