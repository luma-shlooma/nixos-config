# A function to make all values in a nested attribute set default values.
# NOTE: This includes lists so the default nix behavior of joining lists will NOT apply.
{ lib, ... }:

let
  mkAllDefault = apply_lists: lib.mapAttrs (name: value:
    if builtins.isAttrs value && !lib.attrsets.isDerivation value then
      # Apply recursivley
      mkAllDefault apply_lists value
    else
      if builtins.isList value && !apply_lists then
        # Do not apply to lists if apply_lists is false
        value
      else
        # Apply default priority
        lib.mkDefault value
  );
in
mkAllDefault
