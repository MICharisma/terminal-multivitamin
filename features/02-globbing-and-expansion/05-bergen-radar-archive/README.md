# Globbing and expansion · 05 · Bergen weather radar archive, sizing the sweeps

A weather radar near Bergen writes a volume scan every 15 minutes; during a storm some sweeps drop out as empty files and others swell with echoes. The duty forecaster wants the dropped sweeps to re-request, the large scans, the three largest, and the small clear-air scans. Each question is one size qualifier.

**What it teaches**

- `(L0)` finds empty files; `(Lk+100)` finds files over 100 KiB
- `(OL)` sorts largest first; `[1,3]` keeps the first three matches
- `(oL)` sorts smallest first; `(.)` keeps plain files only
- qualifiers stack in one set of parentheses; `^` negates the ones after it, so `(.Lk-50oL^L0)` is "plain, under 50 KiB, smallest first, not empty"

**Lesson steps**

1. Find the empty, dropped sweeps (`(L0)`)
2. Find scans over 100 KiB (`(Lk+100)`)
3. Take the three largest, largest first (`(OL[1,3])`)
4. Stack qualifiers and negate one (`(.Lk-50oL^L0)`)

**Files**

| File | Role |
| --- | --- |
| [`radar_sweeps.zsh`](radar_sweeps.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/05-bergen-radar-archive/radar_sweeps.zsh
tests/run-examples.zsh 05-bergen-radar-archive
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
