{ lib, ... }:

{
  options.theme.modules.swaylock = {
    options = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        The swaylock-effects command line flags and options for visual theming.
        This should only be for visual effect, not using functional options like `--grace`.
      '';
    };
  };
}
