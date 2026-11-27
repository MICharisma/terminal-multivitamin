# Processes and jobs · 09 · Bogotá observatory, timing plate exposures with zsh's time

At the National Observatory in Bogotá, each plate exposure is an external script timed with zsh's `time` keyword and a custom `TIMEFMT`. The report is captured from stderr, and the digits are scrubbed so the lesson stays stable across machines.

**What it teaches**

- zsh's `time` keyword times an external command and prints to stderr (not a shell function)
- `$TIMEFMT` shapes the report; include `%*E` (elapsed), `%*U` (user), `%*S` (system)
- redirect the report with `{ time ... } 2> timing.txt` so the script can read it back
- strip the digits so the expected output stays stable across machines

**Lesson steps**

1. Set TIMEFMT for elapsed, user, and system (`TIMEFMT`)
2. Time one exposure and capture stderr (`time`)
3. Time a second plate the same way (`time`)
4. Try a shorter TIMEFMT with %J (`TIMEFMT`)

**Files**

| File | Role |
| --- | --- |
| [`time_exposures.zsh`](time_exposures.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/09-bogota-observatory/time_exposures.zsh
tests/run-examples.zsh 09-bogota-observatory
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
