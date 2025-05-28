{ pkgs, ... }:

{
  # Install arduino
  environment.systemPackages = with pkgs; [
    arduino
    arduino-ide
    arduino-cli
  ];
  # Use appropriate nix-shell w/ python to launch and compile programs
}
