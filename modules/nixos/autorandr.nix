# UNFINISHED
# Realised wayland doesn't use xrandr
# Leave it here incase I switch to xorg
# https://github.com/efim/dotfiles/blob/18c3dd12a596d5fd2a0ca3bc7b734fe9206637b0/nixpkgs/hosts/personal-laptop/home.nix
# https://github.com/efim/dotfiles/blob/18c3dd12a596d5fd2a0ca3bc7b734fe9206637b0/nixpkgs/my-autorandr.nix

{ ... }:

let
  mkOption = pkgs.lib.mkOption;
  types = pkgs.lib.types;
  cfg = config.TODO;
in
{
  options =
  let
    # Valid display types
    xrandr-display = types.enum [
      "eDP-1"
      "DP-1"
      "HDMI-1"
      "DP-2"
      "HDMI-2"
      "DP-3"
      "HDMI-3"
      "DP-1-4"
      "DP-1-5"
      "DP-1-6"
      "eDP-1-2"
    ];
    # Single display settings
    displayOptions = {
      options ={
        name = mkOption {
          description = "xrandr name for display";
          type = xrandr-display;
        };
        fp = mkoption {
          description = ""
        };
      };
    };

  in
}
{
  services.autorandr = {
    enable = true;
  };
}
