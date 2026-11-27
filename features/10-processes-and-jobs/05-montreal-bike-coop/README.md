# Processes and jobs · 05 · Montréal bike cooperative, a repair desk that listens for signals

The repair desk at a Mile End bike cooperative in Montréal listens for signals: `USR1` means a cargo bike has arrived, `HUP` reloads the volunteer roster, and `TERM` finishes the current bolt and quits. Each signal rewrites a status file the front-of-house screen can read.

**What it teaches**

- `trap 'handler' USR1` runs code when the process receives that signal
- `kill -USR1 $pid` sends it; the handler can rewrite a status file
- `TERM` is the polite "please stop"; a trap can shut down cleanly before exiting
- `HUP` is often "reload your config"; the desk rewrites its status when it arrives

**Lesson steps**

1. Install HUP, TERM, and USR1 traps on the desk (`trap`)
2. Start the desk in the background (`&`)
3. Signal a cargo bike with USR1 (`kill -USR1`)
4. Reload the roster with HUP (`kill -HUP`)
5. Stop the desk politely with TERM (`kill -TERM`)

**Files**

| File | Role |
| --- | --- |
| [`signal_desk.zsh`](signal_desk.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/05-montreal-bike-coop/signal_desk.zsh
tests/run-examples.zsh 05-montreal-bike-coop
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
