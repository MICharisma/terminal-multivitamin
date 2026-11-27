# Sorting, counting, and columns · 12 · Kampala boda-boda fare desk, tallying popular routes

A downtown boda stand logs pickup and drop-off roads in a tab-separated file. The fare desk wants counts per route pair using only POSIX tools. `cut -f1,2` pulls the columns, then `sort | uniq -c` merges identical pairs while `read` drops count padding differences between BSD and GNU.

**What it teaches**

- POSIX `sh` can count routes with `cut`, `sort`, and `uniq -c` when bash is unavailable
- `cut -f1,2` pulls origin and destination from a tab-separated ride log
- sorting before `uniq -c` merges identical routes, and padding on the count is ignored if you read two fields

**Lesson steps**

1. Show paired route columns from the log (`cut -f1,2`)
2. Tally routes with sort and uniq -c (`cut -f1,2 | sort | uniq -c`)

**Files**

| File | Role |
| --- | --- |
| [`route_tally.sh`](route_tally.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/ride-log.tsv`](fixtures/ride-log.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/12-kampala-boda-boda-fare-desk/route_tally.sh
tests/run-examples.zsh 12-kampala-boda-boda-fare-desk
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux with any POSIX sh.
