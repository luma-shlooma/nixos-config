{ pkgs, ... }:

{
  # Common user accounts
  users.users.haydn = {
    isNormalUser = true;
    description = "Haydn";
    extraGroups = [ "networkmanager" "wheel" "conf" "video" "audio" "docker" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
