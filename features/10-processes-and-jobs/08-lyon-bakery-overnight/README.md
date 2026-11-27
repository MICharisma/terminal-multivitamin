# Processes and jobs · 08 · Lyon bakery, leaving the overnight bake running under nohup

A bakery on Vieux Lyon leaves the overnight poolish under `nohup` so a hung-up laptop does not stop the bake. `HUP` is ignored, the log keeps growing, and a final `TERM` stops the bake cleanly when the morning shift arrives.

**What it teaches**

- `nohup command &` keeps the command alive after the terminal hangs up; output goes to `nohup.out`
- `nohup` redirects stdin from `/dev/null` and ignores `SIGHUP`
- the parent can exit (or just move on) while the child keeps writing its log
- you still own the process: `kill` it when the bake is done, and clean up `nohup.out`

**Lesson steps**

1. Start the bake under nohup (`nohup`)
2. Show that HUP is ignored (`kill -HUP`)
3. Read the bake log (`nohup`)
4. Stop the bake with TERM (`kill -TERM`)

**Files**

| File | Role |
| --- | --- |
| [`nohup_bake.zsh`](nohup_bake.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/10-processes-and-jobs/08-lyon-bakery-overnight/nohup_bake.zsh
tests/run-examples.zsh 08-lyon-bakery-overnight
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
