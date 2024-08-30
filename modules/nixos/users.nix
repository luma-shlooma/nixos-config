{ pkgs, ... }:

{
  # Common user accounts
  users.users.haydn = {
    isNormalUser = true;
    description = "Haydn";
    extraGroups = [ "networkmanager" "wheel" "conf" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
