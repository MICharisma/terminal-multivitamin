# Environment and PATH · 13 · Osaka brewery IT loft, reading path_helper's PATH

An IT loft above a brewery in Osaka rebuilds the login PATH the macOS way: `path_helper -s` prints assignments from `/etc/paths` and `/etc/paths.d`, `eval` loads them, and the brewery bin is prepended with the `path` array. macOS only.

**What it teaches**

- macOS builds the login PATH with `/usr/libexec/path_helper` from `/etc/paths` and `/etc/paths.d/*`
- `path_helper -s` prints shell assignments (`PATH=...; export PATH;`) ready to `eval`
- `eval $(path_helper -s)` loads that PATH; then prepend your own bin with the `path` array
- Linux has no path_helper; the script exits 2 there and the runner skips it

**Lesson steps**

1. Ask path_helper for the login PATH (`path_helper -s`)
2. Eval the assignments it printed (`eval`)
3. Prepend the brewery bin with the path array (`path=( ... $path )`)

**Files**

| File | Role |
| --- | --- |
| [`path_helper_demo.zsh`](path_helper_demo.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/13-osaka-path-helper/path_helper_demo.zsh
tests/run-examples.zsh 13-osaka-path-helper
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`path_helper`); on Linux it prints a message and exits 2, and the test runner skips it.
