# Switch hardware config based on machine-id
{ mid, ... }:

let
  # Switch based on passed machine ID
  hardwareConfig =
    if mid == "fe889dcd8af841be9944a24ea4f635f1" then
      ./hardware/t14.nix
    else
      throw "Unrecognised machine ID (${machine-id})";
in
{
  imports = [
    hardwareConfig
  ];
}
