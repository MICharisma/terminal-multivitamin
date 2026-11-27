# Homebrew · 02 · Tallinn coding bootcamp Brewfile audit

The kood/Jõhvi web track in Tallinn ships each cohort a Brewfile. Before imaging day, staff parse it to count taps, formulae, and casks — a dry audit with no `brew install`.

**What it teaches**

- a `Brewfile` declares taps, formulae, and casks as plain lines of Ruby DSL
- `while IFS= read -r` walks each line without splitting on spaces inside quotes
- classifying lines lets the desk count what a cohort laptop still needs

**Lesson steps**

1. Walk each Brewfile line without word-splitting (`while IFS= read -r`)
2. Classify taps, formulae, and casks from the Brewfile (`Brewfile`)

**Files**

| File | Role |
| --- | --- |
| [`audit_brewfile.zsh`](audit_brewfile.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/Brewfile`](fixtures/Brewfile) | The cohort Brewfile under audit |

**Try it**

From the repository root:

```sh
features/15-homebrew/02-tallinn-bootcamp-brewfile/audit_brewfile.zsh
tests/run-examples.zsh 02-tallinn-bootcamp-brewfile
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
