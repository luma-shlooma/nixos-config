{ ... }:

{
  # For Home-Manager programs
  nixpkgs.config.allowUnfree = true;

  # Catch for manual `nix-shell` installation
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
  };
}
