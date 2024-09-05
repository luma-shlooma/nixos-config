#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# const
WORKING="working"

# Use on working branch only
branch=$(git branch --show-current)
[[ "$branch" != "$WORKING" ]] && echo "Script for use on ${WORKING} branch" && exit 1

echo "=== NIXOS PUSH ==="
echo " Squash and merge working branch"

# Diff
git --no-pager diff main..HEAD --compact-summary

# confirmation
echo "Enter to proceed, CTRL+C to cancel"
read #-r msg

#[ -z "$msg" ] && echo "Commit message cannot be empty" && exit 1

# Function editor
auto_squash() {
  # Reword and rename
  sed -i '0,/^pick/s//reword/' "$1"
  # Squash rest
  sed -i '1,$s/^pick/squash/' "$1"
}

export GIT_SEQUENCE_EDITOR="auto_squash"

# Squash, Merge, Push
git fetch origin main
git rebase -i origin/main
git checkout main
git merge --no-ff $WORKING
git push origin main

# Reset working
git checkout $WORKING
git reset --hard main

