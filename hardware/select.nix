# Switch hardware config based on machine-id
{ config, lib, ... }:

let
  # Read the ID
  machine-id = builtins.readFile "/etc/machine-id";
in
{
  options = {};

  config = {
    imports = [
      (if machine-id == "fe889dcd8af841be9944a24ea4f635f1" then
        ./hardware/t14.nix
      else
        throw "Unrecognised machine ID (${machine-id})")
    ];
  };
}
