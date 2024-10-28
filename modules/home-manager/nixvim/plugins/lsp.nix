{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nil_ls.enable = true;  # Nix
      bashls.enable = true;  # Bash
      clangd.enable = true;  # C++
      rust_analyzer = {      # Rust
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      pylyzer.enable = true; # Python
      gopls.enable = true;   # Go
    };
  };
}
