# Searching text with grep · 08 · Bratislava tram depot, matching fault codes literally

The tram depot in Bratislava pastes fault strings out of SCADA: `Pantograph[2]`, `Door*3`, `Inverter.temp`. Without `-F` those characters are regex; with `-F` they are literal, which is what you want when the needle is a pasted log line.

**What it teaches**

- `grep -F` (or `fgrep`) treats the pattern as a fixed string: `.` `*` `[` mean themselves
- without `-F`, `Pantograph[2]` is a character class matching `Pantograph2`; with `-F` it is literal
- `-F` is the right tool when the needle comes from a log line you are pasting back in
- combine `-F` with `-n` or `-w` as usual; it only changes how the pattern is read

**Lesson steps**

1. See [2] act as a character class (`grep without -F`)
2. Match brackets literally with -F (`grep -F`)
3. Match a star literally (`grep -F *`)
4. Paste a SCADA token with dots (`grep -Fn`)

**Files**

| File | Role |
| --- | --- |
| [`fault_codes.zsh`](fault_codes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/08-bratislava-tram-faults/fault_codes.zsh
tests/run-examples.zsh 08-bratislava-tram-faults
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
