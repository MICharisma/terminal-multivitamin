# Quoting and parameter expansion · 06 · Kuala Lumpur secondary school, splitting the timetable

A secondary school in Kuala Lumpur keeps Monday's timetable as one line per class: seven comma-separated periods, with a blank for assembly. `(f)` splits the file into lines; `(s:,:)` drops empty periods; `"${(@s:,:)...}"` keeps them so period numbers stay honest; `(j: | :)` and `(F)` format the board.

**What it teaches**

- `${(f)"$(<file)"}` splits a file's contents into an array of lines
- `${(s:,:)periods}` splits a string on commas, and drops empty fields
- `"${(@s:,:)periods}"`, quoted with `@`, keeps the empty fields, so period numbers stay right
- `${(j: | :)array}` joins an array with a separator; `${(F)array}` joins with newlines

**Lesson steps**

1. Split the file into lines (`${(f)...}`)
2. Split on commas, dropping empty fields (`${(s:,:)...}`)
3. Keep empty fields with @ and quotes (`"${(@s:,:)...}"`)
4. Join periods for the board (`${(j: | :)array}`)
5. Join Maths classes with newlines (`${(F)array}`)

**Files**

| File | Role |
| --- | --- |
| [`timetable.zsh`](timetable.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/timetable.txt`](fixtures/timetable.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/06-kuala-lumpur-school-timetable/timetable.zsh
tests/run-examples.zsh 06-kuala-lumpur-school-timetable
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
