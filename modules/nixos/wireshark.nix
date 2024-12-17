{ pkgs, ... }:

{
  # Wireshark
  programs.wireshark.enable = true;
  
  # Termshark
  environment.systemPackages = with pkgs; [
    wireshark # Seemingly not added in enable
    termshark
  ];

  # Requires user added to wireshark group
}
