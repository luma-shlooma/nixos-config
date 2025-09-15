{ inputs, ... }:

{
  imports = [
    # Nixvim
    inputs.nixvim.homeModules.nixvim
    # Settings
    ./options.nix
    ./autocommands.nix
    # Plugins
    (import ./plugins)
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
