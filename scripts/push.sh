#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# const
WORKING="working"

branch=$(git branch --show-current)
[[ "$branch" != "$WORKING" ]] && echo "Script for use on ${WORKING} branch" && exit 1

# Diff
git --no-pager diff main..HEAD --compact-summary

# confirmation
echo "Provide commit message to proceed, CTRL+C to cancel"
read -r msg

[ -z "$msg" ] && echo "Commit message cannot be empty" && exit 1

# Squash, Merge, Push
git fetch origin main
git rebase -i origin/main --autosquash --autostash --rebase-merges
git checkout main
git merge --no-ff $WORKING -m "$msg"
git push origin main

# Reset working
git checkout $WORKING
git reset --hard main

