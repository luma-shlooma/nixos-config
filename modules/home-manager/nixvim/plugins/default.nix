{
  # Plugins
  programs.nixvim.imports = [
    ./autopairs.nix
    ./colorful-menu.nix
    ./blink/default.nix
    ./icons.nix
    ./lsp.nix
    ./surround.nix
    ./telescope.nix
    ./treesitter.nix
    ./yazi.nix
  ];
}
