{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      marksman.enable = true;  # Markdown
      nil_ls.enable = true;    # Nix
      bashls.enable = true;    # Bash
      clangd.enable = true;    # C++
      rust_analyzer = {        # Rust
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      pylyzer.enable = true;   # Python
      gopls.enable = true;     # Go
      arduino_language_server = {
        enable = true; # Arduino
        cmd = [
          "arduino-language-server"
          "--fqbn" "m5stack:esp32:m5stack_cores3"
        ];
        extraOptions.capabilities.textDocument.semanticTokens = {
          dynamicRegistration = false;
          tokenTypes = {};
          tokenModifiers = {};
          formats = {};
        };
      };
    };
  };
}
