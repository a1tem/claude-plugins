# claude-plugins

Personal Claude Code plugin marketplace (`a1tem-plugins`).

| Plugin | What it is | Source |
|---|---|---|
| `seoo-seo` | 20 SEO and content audit skills; `site-audit-orchestrator` routes general requests | [SEOO skill pack](https://www.seoo.tools), MIT |

## Install (any machine)

In Claude Code:

```
/plugin marketplace add a1tem/claude-plugins
/plugin install seoo-seo@a1tem-plugins
```

Skills show up namespaced, e.g. `seoo-seo:site-audit-orchestrator`.

## Layout

```
.claude-plugin/marketplace.json        marketplace: lists every plugin in this repo
plugins/seoo-seo/
  .claude-plugin/plugin.json           plugin manifest (name, version)
  skills/<skill>/SKILL.md              the 20 skills
  README.md, CHANGELOG.md, LICENSE...  the author's files, unchanged
scripts/update-seoo.sh                 pulls a new SEOO release in
```

## Branches

- **`main`**: what gets installed. Upstream files plus our plugin manifests and any edits we make.
- **`upstream/seoo`**: the author's files exactly as downloaded, nothing else. Never edit it by hand.

Keeping the pristine copy on its own branch is what lets git merge a new release on top of our
edits instead of overwriting them.

## Updating to a new SEOO release

1. Download and unzip the new pack (e.g. to `~/Downloads/seoo-skill-pack`). Check `CHANGELOG.md`
   in it to see what changed.
2. From this repo, on `main` with a clean working tree:

   ```bash
   scripts/update-seoo.sh ~/Downloads/seoo-skill-pack
   ```

   It commits the new files to `upstream/seoo`, merges them into `main`, sets the plugin version
   from the pack's `VERSION` file, and pushes both branches.
3. In Claude Code: `/plugin marketplace update a1tem-plugins` (or restart Claude Code; updates also
   happen on startup when auto-update is on for the marketplace).

**If the merge conflicts** (the author changed lines we also edited), the script stops and prints
what to do: fix the files `git status` lists, `git add -A && git commit --no-edit`, set the
version in `plugins/seoo-seo/.claude-plugin/plugin.json`, commit, and
`git push origin main upstream/seoo`.

<details><summary>Same thing by hand</summary>

```bash
git checkout upstream/seoo
rsync -a --delete --exclude .git --exclude .DS_Store ~/Downloads/seoo-skill-pack/ plugins/seoo-seo/
git add -A && git commit -m "Upstream SEOO skill pack vX.Y.Z"
git checkout main && git merge upstream/seoo
# edit "version" in plugins/seoo-seo/.claude-plugin/plugin.json -> X.Y.Z
git commit -am "seoo-seo: bump to X.Y.Z"
git push origin main upstream/seoo
```
</details>

## Making our own edits

Edit files under `plugins/seoo-seo/` on `main`, then bump `version` in
`plugins/seoo-seo/.claude-plugin/plugin.json` (e.g. `1.1.1` -> `1.1.1-a1tem.1`), commit, push, and
run `/plugin marketplace update a1tem-plugins`. **Always bump the version**: Claude Code caches
plugins by version and won't pick up changes without it.

Before pushing, `claude plugin validate .` checks the manifests.

## Adding another plugin

Put it in `plugins/<name>/` with its own `.claude-plugin/plugin.json`, add an entry to
`.claude-plugin/marketplace.json`, and push. If it is copied from someone else, give it its own
`upstream/<name>` branch the same way.

## Licence

`plugins/seoo-seo` is © SEOO Tools, MIT licence (see `plugins/seoo-seo/LICENSE`). Keep their
copyright line if you share or change it.
