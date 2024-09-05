#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# const
WORKING="working"

branch=$(git branch --show-current)
[[ "$branch" != "$WORKING" ]] && echo "Script for use on ${WORKING} branch" && exit 1

# TODO: Some kind of diff display

# confirmation
echo "Enter to proceed, CTRL+C to cancel"
read

# Squash, Merge, Push
git rebase -i main
git checkout main
git merge --ff-only $WORKING -e
git push origin main

# Reset working
git checkout $WORKING
git reset --hard main

