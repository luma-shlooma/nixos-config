# Controlled Theme
{ config, lib, ... }:

lib.mkIf (config.theme.name == "alpha")
{
  programs.zsh = {
    # Uses default alacritty colours
    # Theme set through oh-my-zsh
    oh-my-zsh = {
      theme = "pi";
      # TODO: Include pi theme in config - currently requires manual download
      custom = "${config.home.homeDirectory}/.oh-my-zsh/custom";
    };
  };
}
