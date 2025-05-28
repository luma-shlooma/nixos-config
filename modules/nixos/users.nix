{ pkgs, ... }:

{
  # Common user accounts
  users.users.haydn = {
    isNormalUser = true;
    description = "Haydn";
    extraGroups = [ "networkmanager" "wheel" "conf" "video" "audio" "docker" "lxc-user" "wireshark" "dialout" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
