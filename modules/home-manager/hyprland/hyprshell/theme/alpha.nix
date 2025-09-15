# Controlled Theme
{ config, lib, ... }:

lib.mkIf (config.theme.name == "alpha")
{
  # ...
}
