# Processes and jobs · 11 · Muscat desalination plant, finding who holds the valve lock

At a desalination plant outside Muscat, a valve lock file must not be removed while anyone holds it open. A child keeps a file descriptor on the lock with `exec {fd}<>`, `lsof` names the holders, and only after `TERM` does the script delete the file.

**What it teaches**

- `lsof filename` lists every process that has that file open
- hold a lock by keeping a file descriptor open: `exec {fd}<>lock` in a child
- `lsof -t file` prints just the pid, handy for scripts
- after the holder exits, `lsof` finds nobody; delete the lock file only then

**Lesson steps**

1. Hold the lock open with a file descriptor (`exec {fd}<>`)
2. List holders with lsof -Fpc (`lsof`)
3. Get just the pids with lsof -t (`lsof -t`)
4. Release and remove the lock (`kill -TERM`)

**Files**

| File | Role |
| --- | --- |
| [`lsof_lock.zsh`](lsof_lock.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/11-muscat-desalination-lock/lsof_lock.zsh
tests/run-examples.zsh 11-muscat-desalination-lock
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
