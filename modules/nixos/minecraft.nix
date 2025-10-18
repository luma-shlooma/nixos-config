{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # This is broken for v1.19+
    #minecraft
    # Prism launcher prefered
    prismlauncher
    # FTB launcher as backup (some issues with some servers)
    ftb-app
  ];
}
