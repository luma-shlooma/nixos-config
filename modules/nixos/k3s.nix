{ ... }:

{
  # Enable
  services.k3s = {
    enable = true;
    # ...
    extraFlags = [
      "--write-kubeconfig-mode 644"
    ];
  };
}
