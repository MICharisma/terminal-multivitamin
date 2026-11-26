# Homebrew · 11 · Medellín conservatory Brewfile dump

EAFIT's conservatory lab in Medellín keeps a committed Brewfile for practice-room Macs. `brew bundle dump` writes a live copy into the temp folder; `diff` shows that someone added `timidity` without updating git.

**What it teaches**

- `brew bundle dump --file PATH --force` writes a Brewfile from what is installed
- dumping into the temp folder keeps the repo's committed Brewfile untouched
- `diff` shows drift between the committed file and the live machine

**Lesson steps**

1. Dump the live machine's Brewfile into the temp folder (`brew bundle dump`)
2. Diff the dump against the committed Brewfile (`brew bundle dump`)

**Files**

| File | Role |
| --- | --- |
| [`dump_brewfile.zsh`](dump_brewfile.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub dump output and the committed Brewfile |

**Try it**

From the repository root:

```sh
features/15-homebrew/11-medellin-conservatory-dump/dump_brewfile.zsh
tests/run-examples.zsh 11-medellin-conservatory-dump
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
