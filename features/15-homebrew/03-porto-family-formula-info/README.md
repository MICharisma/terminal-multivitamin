# Homebrew · 03 · Porto family laptop formula cards

The Oliveira family laptop in Porto already has ffmpeg for school video projects. Before sharing the machine with a cousin, they print a formula card from `brew info --json=v1` — name, description, stable version — without touching the install.

**What it teaches**

- `brew info --json=v1 FORMULA` prints a machine-readable card for one formula
- the JSON array's first object holds `name`, `desc`, and `versions.stable`
- parsing with Python keeps the lesson free of a `jq` dependency

**Lesson steps**

1. Fetch ffmpeg's card as JSON (`brew info --json=v1`)
2. Extract name, description, and stable version (`brew info --json=v1`)

**Files**

| File | Role |
| --- | --- |
| [`formula_cards.zsh`](formula_cards.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew` and a canned `info/ffmpeg.json` response |

**Try it**

From the repository root:

```sh
features/15-homebrew/03-porto-family-formula-info/formula_cards.zsh
tests/run-examples.zsh 03-porto-family-formula-info
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
