#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Trim all profiles
# A little crude

/etc/nixos/scripts/trim.sh 5 3 user
/etc/nixos/scripts/trim.sh 5 3 home-manager
sudo /etc/nixos/scripts/trim.sh 5 3 system
