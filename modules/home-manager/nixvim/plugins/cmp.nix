{
  # Enable cmp and smaller autocompletion plugins
  programs.nixvim.plugins = {
    luasnip.enable = true;
    # Graphics on cmp menu
    lspkind = {
      enable = true;
      settings = {
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path =     "[path]";
            luasnip =  "[snip]";
            buffer =   "[buffer]";
          };
        };
      };
    };
    # Completion engine
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental.ghost_text = true;
        performance.max_view_entries = 30;
        snippet.expand = "luasnip";
        formatting.fields = [ "kind" "abbr" "menu" ];
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
        sources = [
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keyword_length = 3;
          }
        ];
      };
    };
    # LSP
    cmp-nvim-lsp.enable = true;
    # File paths
    cmp-path.enable = true;
  };
}
