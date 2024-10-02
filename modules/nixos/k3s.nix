{ ... }:

{
  # Enable
  services.k3s = {
    enable = true;
    extraFlags = [
      # Allow users to read
      "--write-kubeconfig-mode 644"
    ];
    gracefulNodeShutdown.enable = true;
  };
}
