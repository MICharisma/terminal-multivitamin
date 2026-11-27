# Pipes and redirection · 10 · Cape Town solar installer's nightly report, in portable sh

A solar installer in Cape Town runs a nightly report over the inverters it maintains, from a library in Khayelitsha to a winery in Stellenbosch. The report runs from cron under whatever `/bin/sh` the server has, so it sticks to POSIX: `exec` sends the rest of the script to a log, saved descriptors bring the terminal back, and one group redirection collects a batch.

**What it teaches**

- `exec 3>&1 4>&2` keeps copies of the terminal's stdout and stderr as descriptors 3 and 4
- `exec >report.log 2>&1` (no command) redirects the rest of the script; `exec 1>&3 2>&4` undoes it
- `{ ...; } >> file` redirects a whole group of commands once instead of line by line
- `>&2` sends a warning to stderr; `2>>errors.log` collects them
- `&>file` is bash and zsh only: dash reads `cmd &>file` as `cmd &` plus `>file`, so POSIX scripts write `>file 2>&1`

**Lesson steps**

1. Save the terminal's stdout and stderr (`exec 3>&1`)
2. Redirect the rest of the script to a log (`exec > file 2>&1`)
3. Restore the terminal and read the log (`exec 1>&3`)
4. Redirect a whole group of commands once (`{ ...; } >> file`)

**Files**

| File | Role |
| --- | --- |
| [`nightly_report.sh`](nightly_report.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/10-cape-town-solar-nightly-report/nightly_report.sh
tests/run-examples.zsh 10-cape-town-solar-nightly-report
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
