{
  # Indent Highlights
  plugins.blink-indent = {
    enable = true;
    settings = {
      static.enabled = false;
      scope = {
        highlights = [ "BlinkIndent" ];
        underline = {
          enabled = true;
          highlights = [ "BlinkIndentBlueUnderline" ];
        };
      };
    };
  };
}
