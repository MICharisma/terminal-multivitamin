# Sorting, counting, and columns · 02 · Addis Ababa running club, sorting the Entoto time trial

A running club in Addis Ababa holds a Saturday time trial in the eucalyptus forest on Entoto, over 5, 10 and 21 km, and the volunteer timekeeper types the results into a CSV as runners finish. The coach wants them by distance, by group, and as a board with the longest distance first. Each view is one `sort` with the right `-t` and `-k` keys, and each wrong key gives a plausible but wrong order.

**What it teaches**

- `sort -t, -k4,4` compares the fourth comma-separated field as text, so 10 sorts before 5
- `-k4,4n` compares it as a number; a second key `-k5,5` breaks ties by time
- `-k3` means "from field 3 to the end of the line", not "field 3"; `-k3,3` stops at field 3
- a flag on one key, as in `-k4,4nr`, reverses only that key
- `mm:ss` times of the same width sort correctly as text

**Lesson steps**

1. Sort distances as text and see 10 come before 5 (`sort -t, -k4,4`)
2. Sort distances as numbers, then by time (`sort -t, -k4,4n -k5,5`)
3. See -k3 run to the end of the line, and fix it with -k3,3 (`sort -k3 vs -k3,3`)
4. Reverse only the distance key for the coach's board (`sort -k4,4nr`)

**Files**

| File | Role |
| --- | --- |
| [`trial_results.zsh`](trial_results.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/entoto-trial-2026-11-22.csv`](fixtures/entoto-trial-2026-11-22.csv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/02-addis-ababa-time-trial/trial_results.zsh
tests/run-examples.zsh 02-addis-ababa-time-trial
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
