{ config, pkgs, ... }:

{
  # Programs
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -lah";
	configure = "nvim /etc/nixos/configuration.nix";
	rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#work";
      };
      oh-my-zsh = {
	enable = true;
	plugins = [ "sudo" ];
	theme = "pi";
	custom = "${config.home.homeDirectory}/.oh-my-zsh/custom";
      };
    };
  };
  #users.defaultUserShell = pkgs.zsh;
}
