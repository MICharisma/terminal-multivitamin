# Homebrew · 10 · Québec City SaaS brew services board

Hiver, a Québec City SaaS shop, runs postgresql@16 and redis via Homebrew services on each developer Mac. Standup reads `brew services list` into an associative array; nobody starts or stops services from this script.

**What it teaches**

- `brew services list` shows formulae Homebrew can run as background services
- an associative array keyed by formula holds status for a standup board
- this example only reads the list; it never starts or stops a service

**Lesson steps**

1. Read brew services list into an associative array (`brew services list`)
2. Print the standup board from the status table (`typeset -A`)

**Files**

| File | Role |
| --- | --- |
| [`services_board.zsh`](services_board.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew services list` output |

**Try it**

From the repository root:

```sh
features/15-homebrew/10-quebec-saas-services/services_board.zsh
tests/run-examples.zsh 10-quebec-saas-services
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
