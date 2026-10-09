#!/usr/bin/env bash
# Pull a new SEOO skill pack release into plugins/seoo-seo, keeping local edits.
# Usage: scripts/update-seoo.sh ~/Downloads/seoo-skill-pack
set -euo pipefail

SRC="${1:?usage: scripts/update-seoo.sh /path/to/seoo-skill-pack}"
SRC="$(cd "$SRC" && pwd)"
[ -f "$SRC/VERSION" ] && [ -d "$SRC/skills" ] || { echo "Not a skill pack folder: $SRC" >&2; exit 1; }
VER="$(tr -d '[:space:]' < "$SRC/VERSION")"

cd "$(git rev-parse --show-toplevel)"
[ -z "$(git status --porcelain)" ] || { echo "Working tree not clean - commit or stash first." >&2; exit 1; }

# 1. Pristine copy of the author's files on the upstream branch
git checkout -q upstream/seoo
rsync -a --delete --exclude .git --exclude .DS_Store "$SRC"/ plugins/seoo-seo/
git add -A
if git diff --cached --quiet; then
  echo "No changes from upstream (already at $VER)."
  git checkout -q main
  exit 0
fi
git commit -qm "Upstream SEOO skill pack v$VER"

# 2. Merge into main (your edits are kept; stops here on conflict)
git checkout -q main
if ! git merge -q --no-edit upstream/seoo; then
  echo "Merge conflict - resolve the files listed by 'git status', then:" >&2
  echo "  git add -A && git commit --no-edit" >&2
  echo "  set \"version\": \"$VER\" in plugins/seoo-seo/.claude-plugin/plugin.json, commit" >&2
  echo "  git push origin main upstream/seoo" >&2
  exit 1
fi

# 3. Bump the plugin version so Claude Code refreshes its cache
sed -i '' -E "s/\"version\": \"[^\"]*\"/\"version\": \"$VER\"/" plugins/seoo-seo/.claude-plugin/plugin.json
git commit -qam "seoo-seo: bump to $VER"
git push -q origin main upstream/seoo

echo "Updated seoo-seo to $VER and pushed."
echo "Now run in Claude Code:  /plugin marketplace update a1tem-plugins"
