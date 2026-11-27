# Searching text with grep · 04 · Belfast primary school, reading today's attendance

A primary school in Belfast takes the Primary 4 register as a CSV: present, absent, late. `grep -v` peels away the present pupils (and the header), and `-c` counts who is away.

**What it teaches**

- `grep -v` prints the lines that do *not* match (the absences, or the noise to drop)
- `grep -c` counts matches; `grep -vc` counts the non-matches
- pipe filters stack: drop the header, then drop present pupils, to leave the absences
- `-v` with an empty match set still exits 0 when every line matched the pattern (none left)

**Lesson steps**

1. Invert the match to drop present pupils (`grep -v`)
2. Stack -v filters to drop the header too (`grep -v | grep -v`)
3. Count absences and lates (`grep -c`)
4. Count the inverted set (`grep -vc`)

**Files**

| File | Role |
| --- | --- |
| [`attendance.zsh`](attendance.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/04-belfast-attendance/attendance.zsh
tests/run-examples.zsh 04-belfast-attendance
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
