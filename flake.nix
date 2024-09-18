{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    #includeHardware = hostModule: {
    #  imports = [
    #    ./hardware/t14.nix # CHANGE TO VARIABLE SOMEHOW
    #    hostModule
    #  ];
    #};
  in
  {
    nixosConfigurations = {
      work = nixpkgs.lib.nixosSystem {
	      specialArgs = {inherit inputs self;};
	      modules = [
	        ./hardware/t14.nix
	        ./hosts/work/configuration.nix
	      ];
      };
      home = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules = [
          ./hardware/pc.nix
          ./hosts/home/configuration.nix
        ];
      };
    };
  };
}
