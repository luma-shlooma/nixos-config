{ config, pkgs, ... }:

{
  # Programs
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        rebuild () {
          [[ -z "$1" ]] && echo "Missing host (arg 1)" && return
	        eval "sudo nixos-rebuild switch --flake /etc/nixos#$1"
        }
      '';
      shellAliases = {
        ll = "ls -lah";
      };
      oh-my-zsh = {
	      enable = true;
	      plugins = [ "sudo" ];
	      theme = "pi";
	      custom = "${config.home.homeDirectory}/.oh-my-zsh/custom";
      };
    };
  };
}
