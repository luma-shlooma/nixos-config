{
  keymaps = [
    # Write
    {
      mode = "n";
      key = "<Leader>w";
      action = ":w<CR>";
    }
    # Quit
    {
      mode = "n";
      key = "<Leader>q";
      action = ":q<CR>";
    }
    # Copy
    {
      mode = [ "n" "v" ];
      key = "<Leader>y";
      action = "\"+y";
    }
    # Paste
    {
      mode = [ "n" "v" ];
      key = "<Leader>p";
      action = "\"+p";
    }
  ];
}
