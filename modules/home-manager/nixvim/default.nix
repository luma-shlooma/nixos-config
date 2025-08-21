{ inputs, ... }:

{
  imports = [
    # Nixvim
    inputs.nixvim.homeModules.nixvim
    # Settings
    ./options.nix
    ./autocommands.nix
    ./colorscheme.nix
    # Plugins
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
