{ config, ... }:

{
  # Setup toucher on shell

  programs.zsh = {
    sessionVariables = {
      TOUCHER_TEMPLATES = "${config.home.homeDirectory}/.config/toucher/";
    };
    shellAliases = {
      t = "/etc/nixos/modules/home-manager/toucher/toucher.sh";
    };

  };

  # TODO
  # Change to use home-managers home. features
  # Explore moving templates into nix config
  # Define custom nix module
}
