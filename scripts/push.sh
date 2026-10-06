#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git

cd /etc/nixos || exit

branch=$(git symbolic-ref --short HEAD)

# Warn if this machine branch is behind main
if [ "$branch" != "main" ]; then
  behind=$(git rev-list --count HEAD..main)
  if [ "$behind" -gt 0 ]; then
    echo ":: Warning: '$branch' is $behind commit(s) behind main."
  fi
fi

# Commit if tree is dirty
if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
  echo ":: Uncommitted changes:"
  git --no-pager diff --compact-summary HEAD /etc/nixos
  echo ""
  read -rp ":: Press ENTER to stage and commit or CTRL+C to cancel: "

  git add --all
  git commit
fi

# Push
if [ "$branch" = "main" ]; then
  echo ":: Pushing main..."
  git push origin main
else
  echo ":: Force pushing '$branch'..."
  git push --force-with-lease origin "$branch"
fi
