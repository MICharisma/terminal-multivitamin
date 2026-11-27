# Processes and jobs · 03 · Prague tram depot, reading the night shift's process list

The night dispatcher at a Prague tram depot checks which trams are still looping on the test track. `ps -o` picks the columns, `ps -p` asks about one tram, `kill -STOP` freezes another so its state letter becomes `T`, and the script always filters by its own pid list — never by grepping `ps` output.

**What it teaches**

- `ps -o pid,ppid,state,command` picks the columns; keep `LC_ALL=C` for a stable header
- `ps -p $pid` asks about one process; `ps -p $pid,$pid` about several
- state letters: `S` sleeping, `T` stopped (and `R` running, `Z` zombie)
- filter with a pid list, never with `ps aux | grep`: that race-matches itself

**Lesson steps**

1. Pick the columns with ps -o (`ps -o`)
2. Ask about one tram with ps -p (`ps -p`)
3. Freeze a tram and read state T (`kill -STOP`)
4. Filter by pid list, never by grep (`ps -p`)

**Files**

| File | Role |
| --- | --- |
| [`list_processes.zsh`](list_processes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/03-prague-tram-depot/list_processes.zsh
tests/run-examples.zsh 03-prague-tram-depot
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
