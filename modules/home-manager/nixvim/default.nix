{ inputs, ... }:

{
  imports = [
    # Nixvim
    inputs.nixvim.homeModules.nixvim
    # Settings
    ./options.nix
    ./autocommands.nix
    # Plugins
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
