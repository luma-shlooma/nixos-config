#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Trim all profiles
# A little crude

gens=5
days=2

/etc/nixos/scripts/trim.sh $gens $days user
/etc/nixos/scripts/trim.sh $gens $days home-manager
sudo /etc/nixos/scripts/trim.sh $gens $days system
