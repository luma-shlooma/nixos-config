{
  programs.nixvim = {
    opts = {

      # Mouse
      mouse = "a";

      # Line number
      number = true;
      
      # Tab options
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      # Presentation
      wrap = false;
      spell = false;
      scrolloff = 8;

    };
  };
}
