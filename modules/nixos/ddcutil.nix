{ pkgs, ... }:

{
  # Enable i2c support
  hardware.i2c.enable = true;

  # Allow user i2c control
  users.users.haydn.extraGroups = [ "i2c" ];

  environment.systemPackages = with pkgs; [
    # cli
    ddcutil
    # gui
    ddcui
  ];
}
