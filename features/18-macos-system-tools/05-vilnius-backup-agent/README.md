# macOS system tools · 05 · Vilnius backup agent plist lint

A co-op in Vilnius drafts a LaunchAgent that would run a nightly backup. The plist is born from a here-document in a temp folder; `plutil -lint` checks it. Nothing is bootstrapped — the script only prints what `launchctl bootstrap` would look like.

**What it teaches**

- a here-document writes a minimal LaunchAgent plist into the sandbox
- `plutil -lint` validates the plist without loading it
- bootstrap stays a printed `would:` line so no persistent agent remains

**Lesson steps**

1. Write the agent plist from a here-document (`here-document`)
2. Lint the plist with plutil (`plutil -lint`)

**Files**

| File | Role |
| --- | --- |
| [`lint_agent.zsh`](lint_agent.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/05-vilnius-backup-agent/lint_agent.zsh
tests/run-examples.zsh 05-vilnius-backup-agent
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
