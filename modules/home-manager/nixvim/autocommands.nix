{
  programs.nixvim.autoCmd = [
    # Spell check on documentation
    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "markdown"
      ];
      command = "setlocal spell spelllang=en_gb";
    }
    # ...
  ];
}
