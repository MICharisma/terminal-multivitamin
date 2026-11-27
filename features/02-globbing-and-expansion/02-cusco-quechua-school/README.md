# Globbing and expansion · 02 · Cusco Quechua language school course folders

A Quechua language school in Cusco sets up next term: six units, each with lessons, audio and exams, plus class slots for three days, morning and afternoon. Brace expansion writes all of those names before any of them exist, which is the difference between braces and globs that this example shows.

**What it teaches**

- brace expansion `{a,b}` and sequences `{01..06}` generate words before any file exists; nested braces multiply into every combination
- `{01..12..3}` steps a sequence; zero padding follows the first number
- brace expansion invents names, globbing only finds existing ones
- `(/)` after a glob keeps directories only (more in slot 04)

**Lesson steps**

1. Create six units of three folders with nested braces (`{01..06}`)
2. Generate every class slot from two word lists (`{a,b}`)
3. Step a sequence by three (`{01..12..3}`)
4. Braces invent names; a glob only finds existing ones (`(N)`)

**Files**

| File | Role |
| --- | --- |
| [`unit_folders.zsh`](unit_folders.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/02-cusco-quechua-school/unit_folders.zsh
tests/run-examples.zsh 02-cusco-quechua-school
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
