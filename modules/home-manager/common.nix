{ ... }:

{
  # Add nixos config scripts to session path
  home.sessionPath = [
    "/etc/nixos/scripts/"
  ];

  # Unfree software
  # For Home-Manager programs
  nixpkgs.config.allowUnfree = true;
  # Catch for manual `nix-shell` installation
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
  };
}
