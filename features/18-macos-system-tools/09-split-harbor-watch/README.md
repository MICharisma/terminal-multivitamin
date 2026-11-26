# macOS system tools · 09 · Split harbor watch with caffeinate -i

A mechanical workshop on Split's harbor runs a one-shot tide log and must not let the Mac idle-sleep mid-watch. `caffeinate -i` wraps a background logger; the script waits, then shows the log line.

**What it teaches**

- `caffeinate -i` prevents idle sleep while its child runs
- a background logger writes one tide line into the sandbox
- `wait` joins the assertion before the ledger prints

**Lesson steps**

1. Prevent idle sleep around the watch (`caffeinate -i`)

**Files**

| File | Role |
| --- | --- |
| [`harbor_watch.zsh`](harbor_watch.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/09-split-harbor-watch/harbor_watch.zsh
tests/run-examples.zsh 09-split-harbor-watch
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
