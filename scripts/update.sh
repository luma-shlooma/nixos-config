#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git jq fzf

cd /etc/nixos || exit

branch=$(git symbolic-ref --short HEAD)
if [ "$branch" != "main" ]; then
  echo ":: Error: updates must be run from main."
  exit 1
fi

# List all inputs from flake.lock
inputs=$(jq -r '.nodes.root.inputs | keys[]' flake.lock)

echo ":: Select inputs to update (TAB to multi-select, CTRL+A for all, ENTER to confirm):"
selected=$(echo "$inputs" | fzf --multi --height=40% --bind ctrl-a:select-all)

if [ -z "$selected" ]; then
  echo ":: No inputs selected."
  exit 0
fi

echo ""
echo ":: Updating:"
echo "$selected"
echo ""
read -rp ":: Press ENTER to update or CTRL+C to cancel: "

while IFS= read -r input; do
  echo ":: Updating $input..."
  nix flake update "$input"
done <<< "$selected"

echo ":: Done."
