{
  description = "Nixos config flake";

  inputs = {
    # Nix package collection - unstable channel
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Firefox userChrome tweaks for better performance/behaviour
    betterfox = {
      url = "github:HeitorAugustoLN/betterfox-nix";
    };

    # Dependency of walker, declared explicitly to allow follows
    elephant = {
      url = "github:abenz1267/elephant";
    };

    # Firefox extension packages from NUR
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home environment and dotfile manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Phinger cursor theme for Hyprland
    hyprcursor-phinger = {
      url = "github:jappie3/hyprcursor-phinger";
    };

    # Niri scrollable-tiling Wayland compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative Flatpak management
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    };

    # Neovim configured via Nix modules
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia desktop shell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia greeter
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Application launcher
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    # Custom lib functions
    funcs = {
      mkAllDefault = (import ./lib/mkAllDefault.nix) nixpkgs.lib;
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs funcs self; };
      modules = [
        # The machine-specific declaration files.
        # These should be present on the chosen build branch.
        # NOTE: ./host/home-manager.nix is imported by the home-manager module.
        ./host/configuration.nix
        ./host/hardware.nix
        # Import all settings
        ./settings/default.nix
        # Import all modules
        ./modules/default.nix
      ];
    };
  };
}
