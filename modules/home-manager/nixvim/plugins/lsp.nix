{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      arduino_language_server = { # Arduino
        enable = true;
        cmd = [
          "arduino-language-server"
          "--fqbn" "m5stack:esp32:m5stack_cores3"
        ];
        extraOptions.capabilities.textDocument.semanticTokens = {
          dynamicRegistration = false;
        };
      };
      bashls.enable = true;    # Bash
      clangd.enable = true;    # C++
      gopls.enable = true;     # Go
      hls = {                  # Haskell
        enable = true;
        installGhc = true;
      };
      marksman.enable = true;  # Markdown
      nil_ls.enable = true;    # Nix
      pylyzer.enable = true;   # Python
      qmlls.enable = true;     # QML
      rust_analyzer = {        # Rust
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };
}
