{
  # Blink providers or adjacent plugins
  imports = [
    # ./indent.nix
    # ./words.nix
  ];
  # Configuration
  plugins.blink-cmp = {
    enable = true;
    settings = {
      # Show documentation by default
      completion = {
        menu = {
          auto_show = true;
          # colorful-menu plugin
          draw.components.label = {
            text.__raw = ''
              function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end
            '';
            highlight.__raw = ''
              function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end
            '';
          };
        };
        documentation = {
          auto_show = true;
        };
      };
      keymap = {
        preset = "none";
        # Ctrl-Enter to select
        "<C-CR>" = [
          "select_and_accept"
        ];
        # Tab / Shift-Tab to navigate list
        "<Tab>" = [
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "fallback"
        ];
        # Ctrl-Space to toggle documentation
        "<C-Space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        # Ctrl-E to hide
        "<C-e>" = [
          "hide"
          "fallback"
        ];
      };
      # Sources 
      sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
        # "dictionary"
      ];
      # Boost LSP suggestions
      sources.providers.lsp.score_offset = 5;
    };
  };
  # Enable luasnip (enables lsp completions)
  plugins.luasnip.enable = true;
}
