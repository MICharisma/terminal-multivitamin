# Processes and jobs · 01 · Porto wine lodge, counting bottles in three lodges at once

A Port wine lodge in Vila Nova de Gaia needs a bottle count from three lodges before the morning shipping list. Each count is a background job; the script keeps the pids, waits for each one, then uses a bare `wait` for a late tawny recount. An EXIT trap kills any worker still running if something fails mid-count.

**What it teaches**

- `command &` starts a background job; `$!` is its process id
- keep the pids in an array and `wait $pid` for each one
- `wait` with no arguments waits for every remaining child
- a trap on EXIT kills any worker still alive, so a failed run leaves nothing behind

**Lesson steps**

1. Start each lodge count in the background (`&`)
2. Wait for each pid in turn (`wait $pid`)
3. Wait for every remaining child with bare wait (`wait`)

**Files**

| File | Role |
| --- | --- |
| [`count_bottles.zsh`](count_bottles.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/01-porto-bottle-counts/count_bottles.zsh
tests/run-examples.zsh 01-porto-bottle-counts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
