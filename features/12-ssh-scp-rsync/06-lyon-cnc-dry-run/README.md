# ssh, scp, and rsync · 06 · Lyon CNC shop dry-run

An atelier in Lyon keeps NC programmes in `programmes/` and a transfer plan for
the machine share. A `while IFS= read -r` loop dry-runs each path with
`rsync --dry-run -av` so the operator can see what would land before anything
moves.

**What it teaches**

- `rsync --dry-run -av` shows what would transfer without writing anything
- a plan file plus `while IFS= read -r` feeds the paths one at a time

**Lesson steps**

1. Show the empty machine share before any transfer (`rsync --dry-run`)
2. Dry-run each programme from the transfer plan (`rsync --dry-run`)
3. Confirm the machine share is still empty after the dry-run (`rsync --dry-run`)

**Files**

| File | Role |
| --- | --- |
| [`dry_run_programmes.zsh`](dry_run_programmes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/programmes/`](fixtures/programmes/) | NC programmes for the fraise and tour jobs |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/06-lyon-cnc-dry-run/dry_run_programmes.zsh
tests/run-examples.zsh 06-lyon-cnc-dry-run
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
