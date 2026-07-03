{
  # Blink providers or adjacent plugins
  imports = [
    ./indent.nix
    # ./words.nix
  ];
  # Configuration
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "default";
        # Additional Ctrl-Enter to select
        "<C-CR>" = [
          "select_and_accept"
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
    };
  };
}
