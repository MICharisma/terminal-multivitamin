# Quoting and parameter expansion · 02 · Montréal theatre, building the surtitle cue file

A theatre in Montréal projects French and English surtitles from a tab-separated cue file. ANSI-C quoting (`$'...'`) puts real tabs and newlines into the file; under `LC_ALL=C` the bytes of é have to be written as `$'Ã©'`, because `$'é'` is refused.

**What it teaches**

- `$'...'` (ANSI-C quoting) turns `\t`, `\n`, and `\'` into a real tab, newline, and quote
- `'\t'` is two characters, backslash and t; `$'\t'` is one
- `IFS=$'\t' read -r` splits a tab-separated line, keeping the spaces inside each field
- `$'\xc3\xa9'` writes the bytes of é in any locale; `$'\u00e9'` needs a UTF-8 locale and fails under `LC_ALL=C`

**Lesson steps**

1. Compare '\t' with $'\t' (`$'\t'`)
2. Write é as UTF-8 bytes that work under LC_ALL=C (`$'\x..'`)
3. Build the cue file with real tabs (`$'...\t...'`)
4. Split each cue on tabs (`IFS=$'\t' read -r`)
5. Hold a two-line surtitle in one string (`$'...\n...'`)

**Files**

| File | Role |
| --- | --- |
| [`surtitle_cues.zsh`](surtitle_cues.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/02-montreal-theatre-surtitles/surtitle_cues.zsh
tests/run-examples.zsh 02-montreal-theatre-surtitles
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
