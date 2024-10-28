{
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./barbar.nix
    ./autosave.nix
    ./autopairs.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  
  # Plugin dependancies
  programs.nixvim.plugins = {
    web-devicons.enable = true;
  };
}
