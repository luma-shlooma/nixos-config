{ config, lib, ... }:

{
  # A list of configured entities
  options.apps.configured = lib.mkOption {
    type = with lib.types; listOf str;
    description = "A list of configured entities. This allows for additional configuration of one entity if another is present.";
  };

  # Helper func
  options.apps.hasConfigured = lib.mkOption {
    type = lib.types.anything;
    default = (search: builtins.elem search config.apps.configured);
    description = "A helper function to check whether is nixos config has configured a named app or entity.";
  };
}
