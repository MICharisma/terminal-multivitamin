# Homebrew · 07 · Brisbane cafe POS outdated report

Paddo Espresso's back-of-house Mac in Brisbane runs the till sync. Monday opening prints an outdated report from `brew outdated --json` inside an `emulate -L zsh` function — upgrades wait for the quiet Tuesday close.

**What it teaches**

- `brew outdated --json=v1` lists formulae with a newer stable version
- a function wrapped in `emulate -L zsh` keeps `setopt` changes local
- the report is read-only: nothing is upgraded on the cafe iPads' host Mac

**Lesson steps**

1. Wrap the report in emulate -L zsh so options stay local (`emulate -L zsh`)
2. List outdated formulae as JSON and print a checklist (`brew outdated --json`)

**Files**

| File | Role |
| --- | --- |
| [`outdated_report.zsh`](outdated_report.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew` and canned outdated JSON |

**Try it**

From the repository root:

```sh
features/15-homebrew/07-brisbane-cafe-outdated/outdated_report.zsh
tests/run-examples.zsh 07-brisbane-cafe-outdated
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
