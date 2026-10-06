#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git

cd /etc/nixos || exit

branch=$(git symbolic-ref --short HEAD)

run_rebuild() {
  git add --all

  echo ":: Changes since last rebuild:"
  git --no-pager diff --compact-summary HEAD /etc/nixos
  echo ""

  behind=$(git rev-list --count HEAD..main)
  if [ "$behind" -gt 0 ]; then
    echo ":: Warning: this branch is $behind commit(s) behind main."
  fi

  read -rp ":: Press ENTER to rebuild or CTRL+C to cancel: "

  echo ":: Rebuilding..."
  sudo nixos-rebuild switch --flake .#nixos
}

if [ "$branch" = "main" ]; then
  branches=$(git branch --format="%(refname:short)" | grep -v "^main$")
  echo ":: Available branches:"
  echo "$branches"
  echo ""
  read -rp ":: Branch to build: " target

  if ! echo "$branches" | grep -qx "$target"; then
    echo ":: Error: branch '$target' not found."
    exit 1
  fi

  trap 'echo ":: Returning to main..."; git checkout main' EXIT

  echo ":: Checking out $target..."
  git checkout "$target"

  run_rebuild
else
  echo ":: Rebuilding on branch '$branch'..."
  run_rebuild
fi
