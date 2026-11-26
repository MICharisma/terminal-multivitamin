# macOS system tools · 10 · Ouagadougou radio prefs export/import

Community radio in Ouagadougou clones a throwaway defaults domain from a mentor Mac to a studio Mac. `defaults export` writes a plist clone; after deleting the domain, `defaults import` restores it — all under `com.micharisma.multivitamin.ouaga-radio`.

**What it teaches**

- `defaults export domain file` snapshots every key to a plist
- `defaults delete` clears the domain before the restore drill
- `defaults import domain file` brings the snapshot back

**Lesson steps**

1. Export the radio domain to a plist (`defaults export`)
2. Import the plist back after a delete (`defaults import`)

**Files**

| File | Role |
| --- | --- |
| [`prefs_roundtrip.zsh`](prefs_roundtrip.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/10-ouagadougou-radio-prefs/prefs_roundtrip.zsh
tests/run-examples.zsh 10-ouagadougou-radio-prefs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
