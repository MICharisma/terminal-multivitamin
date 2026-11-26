# macOS system tools · 12 · Lviv print shop launch agent dry-run

A print shop in Lviv drafts a LaunchAgent that would spool a nightly RIP queue. The script lints the plist, shows the `launchctl print` target it would inspect, and never bootstraps — cleanup is a no-op because nothing loaded.

**What it teaches**

- `plutil -lint` checks the spool agent plist
- `launchctl print` is shown as a `would:` against `gui/$UID/label`
- no bootstrap means no leftover agent on the shop Mac

**Lesson steps**

1. Lint the spool agent plist (`plutil -lint`)
2. Show the launchctl print target (`launchctl print`)

**Files**

| File | Role |
| --- | --- |
| [`spool_agent.zsh`](spool_agent.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/12-lviv-print-agent/spool_agent.zsh
tests/run-examples.zsh 12-lviv-print-agent
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
