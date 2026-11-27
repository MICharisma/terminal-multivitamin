# macOS system tools · 11 · Cebu school handout metadata

A science teacher in Cebu checks that each handout PDF-as-text carries the right display name before AirDrop. Process substitution builds the path list into a file immediately (`cat < <(...)`); `mdls -raw` then reads each name.

**What it teaches**

- process substitution builds the handout path list (`cat < <(...)`)
- `mdls -raw -name kMDItemFSName` prints only the value, no key prefix
- consume `<(...)` immediately; a stored `/dev/fd` goes stale

**Lesson steps**

1. Build the handout list with process substitution (`process substitution`)
2. Print raw FS names with mdls -raw (`mdls -raw`)

**Files**

| File | Role |
| --- | --- |
| [`handout_names.zsh`](handout_names.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/11-cebu-school-handouts/handout_names.zsh
tests/run-examples.zsh 11-cebu-school-handouts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
