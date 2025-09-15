{ lib, ... }:

{
  options.theme.name = lib.mkOption {
    type = lib.types.str;
    description = "The theme to use across the system.";
  };
}
