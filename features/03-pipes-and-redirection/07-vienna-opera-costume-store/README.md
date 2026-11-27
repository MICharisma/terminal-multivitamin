# Pipes and redirection · 07 · Vienna opera costume store, checking the crates after a tour

The costume department of an opera house in Vienna packed Magic Flute, Traviata, and Rosenkavalier costumes for a tour to Tokyo. The crates are back, and two lists, one written while packing and one while unpacking, are in different orders. Process substitution sorts both on the fly, so `diff`, `comm`, and `paste` can compare them without a single temp file.

**What it teaches**

- `<(command)` runs a command and hands its output to another command as a file name
- `diff <(sort a) <(sort b)` and `comm -23 <(sort a) <(sort b)` compare unsorted lists with no temp files
- `paste <(cut ...) <(cut ...)` lines up two derived columns side by side
- `<(...)` is a pipe, readable once; zsh's `=(...)` writes a real temp file for tools that seek or read twice, and removes it when the command ends

**Lesson steps**

1. Diff two unsorted lists with <(sort ...) (`<(...)`)
2. List costumes still missing with comm -23 (`comm -23 <(...) <(...)`)
3. Spot another theatre's costume with comm -13 (`comm -13`)
4. Line up counts per production with paste (`paste <(...) <(...)`)
5. Compare <(...) with zsh's =(...) temp file (`=(...)`)

**Files**

| File | Role |
| --- | --- |
| [`costume_check.zsh`](costume_check.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/packed-for-tour.txt`](fixtures/packed-for-tour.txt) | Fixture copied into the script's temp folder |
| [`fixtures/unpacked-in-vienna.txt`](fixtures/unpacked-in-vienna.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/07-vienna-opera-costume-store/costume_check.zsh
tests/run-examples.zsh 07-vienna-opera-costume-store
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
