{ config, ... }:

{
  # Programs
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        function y() {
	        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	        yazi "$@" --cwd-file="$tmp"
	        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		        builtin cd -- "$cwd"
	        fi
	        rm -f -- "$tmp"
        }
      '';
      shellAliases = {
        ll = "ls -lah";
        gdiff = "git --no-pager diff --compact-summary HEAD .";
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
