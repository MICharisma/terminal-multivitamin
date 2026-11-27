# Globbing and expansion · 06 · Chennai textile export house, this week's purchase orders

A textile export house in Chennai keeps one PDF per purchase order: organic cotton tees for Hamburg, kalamkari cushions for Rotterdam, handloom sarees for Osaka, silk stoles for Lyon. Monday's shipping meeting needs what changed this week, what changed today, and what has gone stale. Modification-time qualifiers answer each question; `zsh/datetime` makes the demo timestamps portable.

**What it teaches**

- `(m-7)` matches files modified less than 7 days ago; `(m+30)` more than 30
- `(mh-24)` counts in hours instead of days
- `(om[1])` picks the most recently modified match
- `zsh/datetime` gives `$EPOCHSECONDS` and `strftime`, so the script can stamp files "3 days ago" with `touch -t` on both macOS and Linux

**Lesson steps**

1. Stamp files hours in the past, portably (`strftime`)
2. Match orders changed in the last 7 days (`(m-7)`)
3. Count in hours instead of days (`(mh-24)`)
4. Find orders untouched for over 30 days (`(m+30)`)
5. Pick the most recent order (`(om[1])`)

**Files**

| File | Role |
| --- | --- |
| [`this_week.zsh`](this_week.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/06-chennai-textile-export/this_week.zsh
tests/run-examples.zsh 06-chennai-textile-export
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
