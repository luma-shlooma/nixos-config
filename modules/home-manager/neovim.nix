{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim 
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    # Tab space 2
    extraConfigVim = ''
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set number
    '';
    # Plugins
    plugins = {
      # Language servers
      lsp = {
        enable = true;
        servers = {
          nil-ls.enable = true; # Nix
          bashls.enable = true; # Bash
          rust-analyzer = {     # Rust
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          pylyzer.enable = true; # Python
          gopls.enable = true;   # Go
        };
      };

      # Autocompletion
      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental = { ghost_text = true; };
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          snippet = { expand = "luasnip"; };
          formatting = { fields = [ "kind" "abbr" "menu" ]; };
          sources = [
            { name = "nvim_lsp"; }
            {
              name = "buffer"; # text within current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {
              name = "path"; # file system paths
              keywordLength = 3;
            }
          ];

          window = {
            completion = { border = "solid"; };
            documentation = { border = "solid"; };
          };

          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };

      cmp-nvim-lsp = {
        enable = true; # LSP
      };

      cmp-path = {
        enable = true; # File paths
      };
      
    };
  };


#  programs.neovim = {
#    enable = true;
#    defaultEditor = true;
#    extraConfig = ''
#      set expandtab
#      set tabstop=2
#      set shiftwidth=2
#    '';
#  };
}
