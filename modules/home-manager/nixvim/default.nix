{ inputs, ... }:

{
  imports = [
    # Nixvim
    inputs.nixvim.homeModules.nixvim
    # Plugins
    (import ./plugins)
    # Theme
    ./theme/alpha.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    imports = [
      # Config
      ./autocommands.nix
      ./keybinds.nix
      ./options.nix
    ];
  };
}
