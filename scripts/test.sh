#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Move to config
cd /etc/nixos || exit

# Get host to rebuild
host=${1:-${NIXOS_HOST:-""}}

echo "=== NIXOS TEST ==="
echo " Evaluate NixOS but do not build or switch"
echo " (host: ${host:-"none"})"

# Add new files
git add --all

# Print git diff
echo "Changes made since rebuild..."
git --no-pager diff --compact-summary HEAD /etc/nixos

# Confirmation
echo "Options..."
echo "CTRL+C    | Cancel"
echo "ENTER     | Evaluate"
read -r


# Dry build
cmd="sudo nixos-rebuild dry-build --flake /etc/nixos/#${host} --show-trace --no-build-output"

# Exit on failure
if eval "$cmd"; then
  echo "Evaluation succeeded"
else
  echo "Evaluation failed" && exit 1
fi

