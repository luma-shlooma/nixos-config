#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Const
WORKING="working"

# Get host to rebuild
host=${1:-${NIXOS_HOST:-""}}

echo "=== NIXOS PULL AND REBUILD ==="

# Check elegibility
hash_main=$(git rev-parse "main")
hash_work=$(git rev-parse "$WORKING")
if [ "$hash_main" != "$hash_work" ]; then
  echo "For a quick pull and rebuild, there must not be any changes on '$WORKING'"
  echo "Manage manually"
fi

# Eh, finish this later
