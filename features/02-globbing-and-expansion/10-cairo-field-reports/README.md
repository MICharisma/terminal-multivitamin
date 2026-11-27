# Globbing and expansion · 10 · Cairo University Egyptology field season, daily reports

An Egyptology field team from Cairo University files one report per find per day at Saqqara. Some days have no reports: Friday the site is closed, and on the 23rd the Ministry inspector visited. A daily summary must handle empty days without crashing or looping over a literal `*.txt`.

**What it teaches**

- by default (`nomatch`) a glob with no matches is an error and the command never runs
- `(N)` on one glob, or `setopt null_glob` in a function, turns no match into nothing
- `(( $#reports ))` checks for an empty array before looping
- a `nomatch` failure can be tested safely inside a `( subshell )`

**Lesson steps**

1. See the default no-match error stop a command (`setopt nomatch`)
2. Turn on null_glob for one function (`setopt null_glob`)
3. Check the count before looping (`$#array`)
4. Use (N) on a single glob instead (`(N)`)

**Files**

| File | Role |
| --- | --- |
| [`day_reports.zsh`](day_reports.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/10-cairo-field-reports/day_reports.zsh
tests/run-examples.zsh 10-cairo-field-reports
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
