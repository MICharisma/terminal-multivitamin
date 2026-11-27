# Homebrew · 01 · Amman coworking desk Homebrew prefix

At Shams Desk in Amman, a freelancer's new MacBook needs Homebrew on PATH before the first `rg` call. The desk images Apple Silicon machines, so the script finds the prefix, the ripgrep keg path, and whether `bin` is already on PATH — without installing anything.

**What it teaches**

- `brew --prefix` prints the Homebrew root (Apple Silicon `/opt/homebrew`, Intel `/usr/local`)
- `brew --prefix FORMULA` shows where that formula is or would be installed
- checking whether `$PATH` already contains `$prefix/bin` avoids doubling the entry

**Lesson steps**

1. Print the Homebrew root with brew --prefix (`brew --prefix`)
2. Ask where ripgrep's keg lives (`brew --prefix FORMULA`)
3. Check whether PATH already includes the Homebrew bin (`PATH`)

**Files**

| File | Role |
| --- | --- |
| [`prefix_tour.zsh`](prefix_tour.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew` and a fake Homebrew prefix tree |

**Try it**

From the repository root:

```sh
features/15-homebrew/01-amman-coworking-prefix/prefix_tour.zsh
tests/run-examples.zsh 01-amman-coworking-prefix
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
