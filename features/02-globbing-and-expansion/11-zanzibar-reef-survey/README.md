# Globbing and expansion · 11 · Zanzibar reef survey photos, in bash

A reef conservation team surveys coral along numbered transects off Mnemba Atoll, Zanzibar. Underwater cameras write `.JPG`, `.jpg` and `.jpeg`, some frames are blurry, and some dives have no video. This one is written in bash to show `extglob`, `nocaseglob` and `nullglob`, and it runs on macOS's bash 3.2.

**What it teaches**

- bash needs `shopt -s extglob` for `@(a|b)`, `+(digits)`, and `!(pattern)`
- `extglob` must be on before bash parses the line that uses it, so set it near the top, not inside the function that needs it
- `nocaseglob` lets `*.jpg` match the camera's `.JPG`; `nullglob` drops non-matches
- works in macOS's bash 3.2 as well as newer bash

**Lesson steps**

1. Match either extension spelling, in any case (`@(a|b)`)
2. Match one or more digits (`+(pattern)`)
3. Exclude blurry photos with !(...) (`!(pattern)`)
4. Loop over a possibly empty array safely in bash 3.2 (`shopt -s nullglob`)

**Files**

| File | Role |
| --- | --- |
| [`sort_dives.sh`](sort_dives.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/11-zanzibar-reef-survey/sort_dives.sh
tests/run-examples.zsh 11-zanzibar-reef-survey
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
