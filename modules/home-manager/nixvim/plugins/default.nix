{
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./barbar.nix
    ./indent.nix
    ./surround.nix
    #./autosave.nix
    ./autopairs.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  
  # Plugin dependancies
  programs.nixvim.plugins = {
    web-devicons.enable = true;
  };
}
