{ config, lib, ... }:
with lib;
let
  # This module's config options
  cfg = config.modules.k3s;
in
{
  # Options
  options.modules.k3s.enable = mkEnableOption "Kubes";

  # Config
  config = mkIf cfg.enable {

    # ...
    services.k3s = {
      enable = true;
      extraFlags = [
        # Allow users to read
        "--write-kubeconfig-mode 644"
      ];
      gracefulNodeShutdown.enable = true;
    };

  };
}
