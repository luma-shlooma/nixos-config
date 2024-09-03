#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Get host to rebuild
host=${1:-${NIXOS_HOST:-""}}

echo "===NIXOS REBUILD==="
echo " (host: ${host:-"none"})"

# Print git diff
echo "Changes made since rebuild..."
git --no-pager diff --compact-summary /etc/nixos

# Confirmation
echo "Press ENTER to rebuild, CTRL+C to cancel"
read

# Git actions
git add --all
# TODO: Auto squashed commits on rebuild

