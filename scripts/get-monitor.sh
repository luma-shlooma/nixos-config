#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

swaymsg -t get_outputs | jq -r --arg target "$1" '.[] | select(($target) == (.make + " " + .model + " " + .serial)) | .name'

