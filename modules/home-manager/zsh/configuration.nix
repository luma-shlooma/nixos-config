{ config, ... }:

{
  # Programs
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      # Use new dot directory
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = ''
        function y() {
	        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	        yazi "$@" --cwd-file="$tmp"
	        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		        builtin cd -- "$cwd"
	        fi
	        rm -f -- "$tmp"
        }
        function dupe() {
          # Init
          dir=""
          nix_dir=""
          cmd=""
          # Start search here
          dir="$(pwd)"
          # Are we in a nix-shell or nix develop environment?
          if [ "$IN_NIX_SHELL" = "pure" ] || [ "$IN_NIX_SHELL" = "impure" ]; then
            # Walk up to find a flake or shell file
            nix_dir="$dir"
            while [ "$nix_dir" != "/" ]; do
              if [ -f "$nix_dir/flake.nix" ]; then
                cmd="nix develop \"$nix_dir\""
                break
              elif [ -f "$nix_dir/shell.nix" ] || [ -f "$nix_dir/default.nix" ]; then
                cmd="nix-shell \"$nix_dir\""
                break
              fi
              nix_dir="$(dirname "$nix_dir")"
            done
            if [ -n "$cmd" ]; then
              bash -c "alacritty --working-directory=$dir -e sh -c $cmd &"
            else
              echo "nix-shell detected, but no shell.nix or flake.nix found."
            fi
          else
            # Not in a nix shell — just dupe the current shell at the same dir
            bash -c "alacritty --working-directory=$dir &"
          fi
        }
      '';
      shellAliases = {
        ll = "ls -lah";
        gdiff = "git --no-pager diff --compact-summary HEAD .";
      };
      oh-my-zsh = {
	      enable = true;
	      plugins = [ "sudo" ];
      };
    };
  };
}
