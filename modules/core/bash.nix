{ config, lib, ... }:
with lib;
let
  # The configured user
  user = config.settings.system.user;
  # Home-manager config
  home = config."home-manager".users.${user};
  # This module's config options
  cfg = config.modules.bash;
in
{
  # Options
  options.modules.bash.disable = mkOption {
    type = types.bool;
    default = false;
    description = "Disable bash. This isn't recommended.";
    example = true;
  };

  # Config
  config = mkIf (!cfg.disable) {

    # Require home-manager to be enabled
    modules.homeManager.enable = true;
    
    # The home-manager config
    home-manager.users."${user}" = {

      # Enable bash
      programs.bash = {
        enable = true;
        # Add y yazi alias for fs traversal
        initExtra = mkIf config.modules.yazi.enable ''
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
        '';
      };

    };

    # Set package if preferred
    settings.terminal.shell.package = mkIf (config.settings.terminal.shell.selected == "bash") home.programs.bash.package;

  };
}
