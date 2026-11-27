# Editing streams with sed and awk · 02 · Yangon ferry timetable

The Inya Lake and Dala ferries post one text file per route per day: a route header, then departure lines. The pier master pulls only the afternoon block or every line that mentions `jetty-1`. Line numbers, a single pattern, and a start/end range are three different `sed` addresses.

**What it teaches**

- `sed -n 'Np'` prints only line N; a range `N,Mp` prints that block
- `sed -n '/pattern/p'` prints lines that match a address
- `sed -n '/from/,/to/p'` prints from a start match through an end match

**Lesson steps**

1. Print only lines 2 through 4 (`sed -n 'Np'`)
2. Print lines that match a pier name (`sed -n '/pattern/p'`)
3. Print from one departure through another (`sed -n '/from/,/to/p'`)

**Files**

| File | Role |
| --- | --- |
| [`ferry_schedule.zsh`](ferry_schedule.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/02-yangon-ferry-timetable/ferry_schedule.zsh
tests/run-examples.zsh 02-yangon-ferry-timetable
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
