
# host/

This directory should contain three files that differ between installs.

A git branch should be made from main which provides these files.

This branch may or may not be tracked on remote, if they are not then it is 
possible to use this nixos-config without pushing to remote.

The three files required are:

**host/configuration.nix**
: This is the top-level configuration file which enables the desired modules.

**host/hardware.nix**
: This is the untouched hardware file auto-generated on installation of nixos.

**host/home-manager.nix**
: Similar to `configuration.nix`, but enables desired home-manager modules.


### Notes:

`system.stateVersion` should be set and untouched in both `configuration.nix` and 
`home-manager.nix`.

`home-manager.nix` is imported as a home-manager file (see `modules/system/home-manager.nix`).

These files **should not** import each other.

Sometimes it is not appropriate to create a custom module, so both `configuration.nix` 
and `home-manager.nix` is welcome to set configuration directly.
