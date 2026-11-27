# Homebrew · 04 · Kyoto print restoration lab casks vs formulae

A mokuhanga restoration lab in Kyoto keeps one Brewfile for the scanner Mac. Before a residency week, staff split formulae (CLI) from casks (GUI) into packing lists with a `case` router — still no installs.

**What it teaches**

- a Brewfile mixes `brew` formulae (CLI tools) and `cask` apps (GUI)
- a `case` router sends each kind to its own packing list for the lab cart
- quoting in the Brewfile (`brew "imagemagick"`) is part of the DSL, not the shell

**Lesson steps**

1. Route each Brewfile line by brew, cask, or tap (`case`)
2. Show the packing lists for the scanner Mac (`Brewfile`)

**Files**

| File | Role |
| --- | --- |
| [`sort_brewfile.zsh`](sort_brewfile.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/Brewfile`](fixtures/Brewfile) | The lab Brewfile to classify |

**Try it**

From the repository root:

```sh
features/15-homebrew/04-kyoto-restoration-casks/sort_brewfile.zsh
tests/run-examples.zsh 04-kyoto-restoration-casks
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
