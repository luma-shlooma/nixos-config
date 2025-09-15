# Controlled Theme
{ config, lib, ... }:

lib.mkIf (config.theme.name == "alpha")
{
  programs.alacritty = {
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        size = 11;
      };
    };
  };
}
