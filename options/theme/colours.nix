{ lib, ... }:

{
  options.theme.colours = lib.mkOption {
    type = with lib.types; attrsOf str;
    description = "Arbitrary description of colours available to and shared across the system's theme.";
  };
}
