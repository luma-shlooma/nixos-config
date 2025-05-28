#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Move to config
cd /etc/nixos || exit

# Const
WORKING="working"

# Get host to rebuild
host=${1:-${NIXOS_HOST:-""}}

echo "=== NIXOS REBUILD ==="
echo " Rebuild and commit changes to config"
echo " (host: ${host:-"none"})"

# Git actions
hash="$(git rev-parse HEAD)"
git add --all

# Print git diff
echo "Changes made since rebuild..."
git --no-pager diff --compact-summary HEAD /etc/nixos

# Confirmation
branch=$(git branch --show-current)
echo "Options..."
echo "CTRL+C    | Cancel"
echo "ENTER     | Default branch behavior (${branch})"
echo "msg ENTER | Commit msg"
read -r msg


# Rebuild
sudo nixos-rebuild switch --flake /etc/nixos/#"${host}"

# Exit on failure
[ $? -ne 0 ] && echo "Rebuild failed, wont commit" && exit 1

# Commit actions
if [[ "$branch" == "main" ]]; then
  # Main, commit if msg
  [ -z "$msg" ] || git commit -m "$msg"
elif [[ "$branch" == "$WORKING" ]]; then
  # Working branch, commit msg or hash
  if [ -z "${msg}" ]; then
    git commit -m "$hash"
  else
    git commit -m "${msg}"
  fi
else
  # Unknown, no commit
  echo "Unknown branch, wont commit"
fi

