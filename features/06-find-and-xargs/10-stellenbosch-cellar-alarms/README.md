# Finding files with find and xargs · 10 · Stellenbosch wine estate, fermentation tank alarms, in portable sh

During harvest on a wine estate outside Stellenbosch, every fermentation tank logs its temperature, and an `ALARM` line means someone has to pump over or free a glycol valve. The cellar master's check runs from cron on a Linux box and by hand on a Mac, so it is written in POSIX `sh`. How `find` hands files to `grep`, one at a time with `\;` or in batches with `+`, changes both what `grep` prints and what `find` returns.

**What it teaches**

- `-exec grep -c ALARM {} \;` runs grep once per file, and grep with one file prints no file name
- `-exec ... {} +` passes many files to one grep, which then prefixes each count with its file
- adding `/dev/null` as an extra file makes grep name the file even when `find` hands it only one
- a failing `-exec ... \;` is just a false test, but a failing `-exec ... {} +` makes `find` itself exit non-zero (POSIX says so), which matters under `set -e`

**Lesson steps**

1. Run grep once per tank with -exec ... \; (`find -exec {} \;`)
2. Batch all tanks into one grep with -exec ... + (`find -exec {} +`)
3. Add /dev/null so grep always names the file (`grep pattern /dev/null {} +`)
4. Compare find's exit status for \; and + (`find -exec {} +`)

**Files**

| File | Role |
| --- | --- |
| [`tank_alarms.sh`](tank_alarms.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/10-stellenbosch-cellar-alarms/tank_alarms.sh
tests/run-examples.zsh 10-stellenbosch-cellar-alarms
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
