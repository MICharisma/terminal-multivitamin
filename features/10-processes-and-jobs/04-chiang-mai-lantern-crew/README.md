# Processes and jobs · 04 · Chiang Mai temple school, signalling the lantern crew

Before Loy Krathong, a temple school in Chiang Mai posts students at the gate, the river, and the roof with lanterns. Each post is a process renamed with `exec -a lantern-crew:…`, so `pgrep -f` and `pkill -f` can signal one post or the whole crew without matching every other `sleep` on the machine.

**What it teaches**

- `pgrep -f pattern` finds process ids by matching the full command line
- `pgrep -P $ppid` finds children of one parent; combine with `-f` for a shortlist
- `pkill -TERM -f pattern` sends a signal by the same match; it returns 1 when nobody matched
- prefer matching a unique marker in the command (`lantern-crew:gate`) over a bare `sleep`

**Lesson steps**

1. Rename each post with exec -a (`exec -a`)
2. Find children of this script with pgrep (`pgrep -P`)
3. Find one post by pattern (`pgrep -f`)
4. Stop one post with pkill (`pkill`)
5. Clear the yard with pkill on the marker (`pkill`)

**Files**

| File | Role |
| --- | --- |
| [`signal_crew.zsh`](signal_crew.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/04-chiang-mai-lantern-crew/signal_crew.zsh
tests/run-examples.zsh 04-chiang-mai-lantern-crew
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
