{
  # Dictionary completion
  plugins.blink-cmp-words.enable = true;
  plugins.blink-cmp = {
    settings.sources.providers.dictionary = {
      name = "blink-cmp-words";
      module = "blink-cmp-words.dictionary";
      opts = {
        dictionary_search_threshold = 3;
        score_offset = 0;
        definition_pointers = [ "!" "&" "^" ];
      };
    };
  };
}
