{ lib, ... }:

{
  # Set the prefered app launcher
  options.apps.launcher = {
    # Name of the launcher (for assertions mostly)
    name = lib.mkOption {
      type = lib.types.str;
      description = "The name of the configured app launcher.";
    };
    # Launch command
    launch = lib.mkOption {
      type = lib.types.str;
      description = "Command to open the chosen app launcher in a the default state.";
    };
    # Dmenu launch command
    dmenu = lib.mkOption {
      type = lib.types.anything;
      description = "A function returning the command to select from a given newline-separated list of options and prompt.";
    };
  };
}
