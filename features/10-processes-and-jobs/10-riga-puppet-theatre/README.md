# Processes and jobs · 10 · Riga puppet theatre, cleaning up stage workers with trap

A puppet theatre in Riga starts three puppeteers for rehearsal and installs an EXIT trap that kills them. The happy path stops them itself; a failed rehearsal `return`s 1 so the trap still cleans up, and the outer script confirms no orphans remain.

**What it teaches**

- `trap stop_workers EXIT` runs on every exit path: success, `exit`, and most signals
- start workers, record their pids, and have the trap kill anything still running
- a function with its own trap shows the failure path without failing the parent script
- after the trap runs, `pgrep` finds nobody from that batch

**Lesson steps**

1. Install an EXIT trap that stops workers (`trap EXIT`)
2. Start the puppeteers and record their pids (`&`)
3. Fail the rehearsal with return 1 (`return`)
4. Run the happy path and the failure path (`trap EXIT`)

**Files**

| File | Role |
| --- | --- |
| [`trap_cleanup.zsh`](trap_cleanup.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/10-riga-puppet-theatre/trap_cleanup.zsh
tests/run-examples.zsh 10-riga-puppet-theatre
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
