# Pipes and redirection · 09 · Hamburg container terminal crane telemetry, in bash

At a container terminal in Hamburg, a script reads hoist loads from a ship-to-shore crane's controller, sorts them, and files them. One night the controller drops the connection after three readings, and the pipeline still reports success, because a pipeline's status is its last command's. This one is written in bash to show `PIPESTATUS` and the bash 3.2 limits on macOS.

**What it teaches**

- a pipeline's exit status is its last command's, so an early failure hides behind a happy `sort`
- bash's `PIPESTATUS` array holds every stage's status (zsh: `pipestatus`); copy it at once, because the next command replaces it
- `set -o pipefail` makes the pipeline fail if any stage fails
- `2>&1 |` sends stderr down the pipe too; `|&` is the bash 4 shorthand, missing from macOS's bash 3.2

**Lesson steps**

1. See an early failure hidden by the last stage (`$?`)
2. Read every stage's status from PIPESTATUS (`PIPESTATUS`)
3. Fail the pipeline with pipefail (`set -o pipefail`)
4. Send stderr down the pipe in bash 3.2 (`2>&1 |`)

**Files**

| File | Role |
| --- | --- |
| [`crane_pipeline.sh`](crane_pipeline.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/09-hamburg-crane-telemetry/crane_pipeline.sh
tests/run-examples.zsh 09-hamburg-crane-telemetry
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux, in macOS's bash 3.2 as well as newer bash.
