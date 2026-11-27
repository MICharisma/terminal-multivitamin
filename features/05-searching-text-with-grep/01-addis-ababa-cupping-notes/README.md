# Searching text with grep · 01 · Addis Ababa coffee exchange, searching the cupping notes

At the Ethiopian Coffee Exchange in Addis Ababa, a day's cupping notes list every lot with origin, process, fragrance, acidity, body and score. A broker greps for Yirgacheffe, counts bright acidities, and learns why an unescaped dot in `86.` is a regex metacharacter.

**What it teaches**

- `grep pattern file` prints every line that contains the pattern
- `grep -c` counts matching lines; exit status is 0 on a match, 1 on none (with `|| true` under `errexit`)
- without `-F` or `-E`, basic regex treats `.` as "any character": `86.` matches `86.5` and `86`
- quote the pattern so the shell does not expand `*` or `?` before grep sees them

**Lesson steps**

1. Find every Yirgacheffe lot (`grep`)
2. Count lots with bright acidity (`grep -c`)
3. See . match any character in basic regex (`basic regex .`)
4. Quote the pattern and handle exit status 1 (`grep exit 1`)

**Files**

| File | Role |
| --- | --- |
| [`cupping_search.zsh`](cupping_search.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/cupping-day.txt`](fixtures/cupping-day.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/01-addis-ababa-cupping-notes/cupping_search.zsh
tests/run-examples.zsh 01-addis-ababa-cupping-notes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
