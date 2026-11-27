# Homebrew · 13 · Addis Ababa GIS desk bundle check

The Ethiopian Mapping Authority GIS desk in Addis Ababa keeps a Brewfile for gdal, postgis, and QGIS. Before a field week, `brew bundle list` and `brew bundle check --verbose` run inside scoped functions — gaps are reported, never installed by this script.

**What it teaches**

- `brew bundle check --verbose` reports missing Brewfile dependencies without installing
- `brew bundle list` names what the Brewfile declares
- an anonymous function `() { ... }` scopes the check and prints a desk summary

**Lesson steps**

1. List what the Brewfile declares (`brew bundle list`)
2. Dry-run brew bundle check and report gaps (`brew bundle check`)
3. Summarize the desk action in an anonymous function (`()`)

**Files**

| File | Role |
| --- | --- |
| [`bundle_check.zsh`](bundle_check.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub bundle commands and the GIS Brewfile |

**Try it**

From the repository root:

```sh
features/15-homebrew/13-addis-ababa-gis-bundle/bundle_check.zsh
tests/run-examples.zsh 13-addis-ababa-gis-bundle
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
