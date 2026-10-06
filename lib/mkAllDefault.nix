# A function to make all values in a nested attribute set default values.
# NOTE:
#  providing true for `apply_lists` will override the default nix behaviour of
#  joining lists and will instead cause them to be replaced - like other values.
lib:
let
  mkAllDefault = apply_lists: lib.mapAttrs (name: value:
    if builtins.isAttrs value && !lib.attrsets.isDerivation value then
      # Apply recursively
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
