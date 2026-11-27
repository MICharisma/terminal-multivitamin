# Processes and jobs · 07 · Amman pharmacy, stopping a whole labelling batch with one signal

A pharmacy on Jabal Amman runs three label printers as one batch. `POSIX::setsid` gives them their own process group, so one `kill -TERM -- -$pgid` stops the counter, the fridge, and the OTC printer together when the pharmacist cancels the run.

**What it teaches**

- a process group is a set of processes that share a pgid; `kill -- -$pgid` signals them all
- `perl -MPOSIX -e 'POSIX::setsid()...'` starts a new session (and group) portably on macOS and Linux
- children started inside that session inherit the group; one TERM reaches every label printer
- `ps -o pgid=` reads the group id; compare it with the leader to confirm they match

**Lesson steps**

1. Start the batch in a new session (`setsid`)
2. Confirm every printer shares the process group (`ps -o pgid=`)
3. Signal the whole group at once (`kill -- -pgid`)

**Files**

| File | Role |
| --- | --- |
| [`process_group.zsh`](process_group.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/07-amman-pharmacy-batch/process_group.zsh
tests/run-examples.zsh 07-amman-pharmacy-batch
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
