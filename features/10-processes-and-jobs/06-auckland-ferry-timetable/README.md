# Processes and jobs · 06 · Auckland ferry timetable desk, waiting on each sailing's check

The ferry desk in Auckland starts berth checks for Waiheke, Devonport, and Bayswater in one order, then `wait`s for them in timetable order. Each child's exit status is that sailing's result, and `wait` on a pid that is not a child is refused.

**What it teaches**

- `wait $pid` waits for one child and returns that child's exit status in `$?`
- a child that exits 0 means success; non-zero means that sailing's check failed
- `wait $unknown` fails immediately when the pid is not a child of this shell
- start the slow check first and wait in timetable order, not launch order

**Lesson steps**

1. Start the checks in launch order (`&`)
2. Wait in timetable order and read each exit status (`wait $pid`)
3. Refuse wait on a pid that is not a child (`wait`)

**Files**

| File | Role |
| --- | --- |
| [`wait_sailings.zsh`](wait_sailings.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/06-auckland-ferry-timetable/wait_sailings.zsh
tests/run-examples.zsh 06-auckland-ferry-timetable
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
