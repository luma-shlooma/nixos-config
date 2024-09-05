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
          rust-analyzer = { # Rust
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          pylyzer.enable = true; # Python
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
            #{ name = "emoji"; }
            {
              name = "buffer"; # text within current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            # { name = "copilot"; } # enable/disable copilot
            {
              name = "path"; # file system paths
              keywordLength = 3;
            }
            {
              name = "luasnip"; # snippets
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

          formatting = {
            format = ''
              function(entry, vim_item)
                local line = vim.fn.getline(vim.fn.line('.'))
                local col = vim.fn.col('.')
                local current_char = line:sub(col, col)

                local comment_patterns = {
                  '^%s*--', -- Lua
                  '^%s*#', -- Bash
                  '^%s*/%*', -- Multi-line start
                  '%*/%s*$' -- Multi-line end
                }

                for _, pattern in ipairs(comment_patterns) do
                  if line:match(pattern) then
                    return nil
                  end
                end

                return vim_item
              end
            '';
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
