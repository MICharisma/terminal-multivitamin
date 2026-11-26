# Homebrew · 12 · Doha hotel IT cellar and cache paths

Front-desk Macs at a Souq Waqif boutique hotel in Doha share one Homebrew prefix. IT prints an asset sheet of `--prefix`, `--cellar`, and `--cache` with `print -f` before reclaiming disk — read-only paths only.

**What it teaches**

- `brew --cellar` is where keg versions live under the prefix
- `brew --cache` is the download cache Homebrew may reclaim
- `print -f` formats a multi-path inventory for the hotel's asset sheet

**Lesson steps**

1. Gather prefix, cellar, and cache paths (`brew --cellar`)
2. Format the hotel asset sheet including the cache (`brew --cache`)

**Files**

| File | Role |
| --- | --- |
| [`path_inventory.zsh`](path_inventory.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub brew path commands and a fake Cellar |

**Try it**

From the repository root:

```sh
features/15-homebrew/12-doha-hotel-cellar/path_inventory.zsh
tests/run-examples.zsh 12-doha-hotel-cellar
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
