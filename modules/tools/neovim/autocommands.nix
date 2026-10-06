{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.user;
  # This module's config options
  cfg = config.modules.neovim;
in
mkIf cfg.enable
{
  
  autoCmd = [
    # # Spell check on documentation
    # {
    #   event = "FileType";
    #   pattern = [
    #     "tex"
    #     "text"
    #     "latex"
    #     "markdown"
    #     "gitcommit"
    #   ];
    #   command = "setlocal spell spelllang=en_gb";
    # }
    # # ...
  ];
}
