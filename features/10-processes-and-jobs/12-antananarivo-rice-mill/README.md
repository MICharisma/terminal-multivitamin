# Processes and jobs · 12 · Antananarivo rice mill, waiting on baggers in portable sh

A rice mill in Antananarivo runs three bagging lines from a POSIX `sh` supervisor. There is no reliable `jobs` in a script, so the pids are kept in a string, joined with `wait "$pid"`, and an EXIT trap kills anything still listed.

**What it teaches**

- POSIX `sh` has `$`! for the last background pid and `wait` for children
- `wait "$pid"` returns that child's exit status; a loop over pids is the portable join
- there is no `jobs -p` you can rely on in a script: keep the pids yourself
- a trap on EXIT kills anything still in the pid list, so a failed mill run leaves no baggers

**Lesson steps**

1. Start each bagger and keep the pids (`&`)
2. Wait for each pid in a portable loop (`wait`)
3. Wait for every remaining child (`wait`)

**Files**

| File | Role |
| --- | --- |
| [`wait_sh.sh`](wait_sh.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/12-antananarivo-rice-mill/wait_sh.sh
tests/run-examples.zsh 12-antananarivo-rice-mill
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
