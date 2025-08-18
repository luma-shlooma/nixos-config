{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # This is broken for v1.19+
    #minecraft
    # Prism launcher alternative
    prismlauncher
  ];
}
