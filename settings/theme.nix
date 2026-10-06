{ lib, ... }:
with lib;
{
  # New options to be used between modules
  options.settings.theme = {
    selected = mkOption {
      type = types.enum [ "default" ];
      default = "default";
      description = "The theme to use across all themed apps.";
    };
    colours = mkOption {
      type = types.attrOf types.str;
      default = {};
      description = "An attribute set of colour names to colour values in hex. Set automatically by theme and can be used in themed apps. The colour names and attribute set structure can differ between themes.";
    };
  };
}
