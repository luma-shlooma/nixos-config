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
echo "Provide commit message to proceed, CTRL+C to cancel"
read -r msg

[ -z "$msg" ] && echo "Commit message cannot be empty" && exit 1

# Function replace all but first 'pick' with 'squash'
auto_squash() {
  sed -i '2,$s/^pick/squash/' "$1"
}

export GIT_SEQUENCE_EDITOR="auto_squash"

# Squash, Merge, Push
git fetch origin main
git rebase -i origin/main
git checkout main
git merge --no-ff $WORKING -m "$msg"
git push origin main

# Reset working
git checkout $WORKING
git reset --hard main

