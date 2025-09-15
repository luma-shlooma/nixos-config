# `module` is a custom parameter.
# It is simply a string identifier for the module making the assertions.
{ module ? "unknown", host, config, lib, ... }:

# Return at set of common assertions available for nixos config
{
  # Always fail, used to mark unfinished modules
  unfinished = {
    assertion = false;
    message = "module '${module}' is unfinished and cannot be used.";
  };
  # Given an expected host, fail if current host does not match
  host = expectedHost: {
    assertion = (host == expectedHost);
    message = "module '${module}' can only be used by the host '${expectedHost}'.";
  };
  # Given a string config path (e.g. "something.enabled") fail if not true (enabled)
  enabled = configPath:
  let
    configIndices = lib.splitString "." configPath;
    configValue = lib.attrByPath configIndices false config;
  in
  {
    assertion = configValue;
    message = "module '${module}' requires 'config.${configPath}' to be enabled.";
  };
}
