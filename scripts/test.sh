#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git

cd /etc/nixos || exit

branch=$(git symbolic-ref --short HEAD)

run_test() {
  behind=$(git rev-list --count HEAD..main)
  if [ "$behind" -gt 0 ]; then
    echo ":: Warning: this branch is $behind commit(s) behind main."
  fi

  read -rp ":: Press ENTER to evaluate or CTRL+C to cancel: "

  echo ":: Evaluating..."
  if sudo nixos-rebuild dry-build --flake .#nixos --no-update-lock-file --option abort-on-warn true --show-trace --no-build-output; then
    echo ":: Evaluation succeeded."
  else
    echo ":: Evaluation failed."
    exit 1
  fi
}

if [ "$branch" = "main" ]; then
  branches=$(git branch --format="%(refname:short)" | grep -v "^main$")
  echo ":: Available branches:"
  echo "$branches"
  echo ""
  read -rp ":: Branch to test: " target

  if ! echo "$branches" | grep -qx "$target"; then
    echo ":: Error: branch '$target' not found."
    exit 1
  fi

  trap 'echo ":: Returning to main..."; git checkout main' EXIT

  echo ":: Checking out $target..."
  git checkout "$target"

  run_test
else
  echo ":: Testing on branch '$branch'..."
  run_test
fi
