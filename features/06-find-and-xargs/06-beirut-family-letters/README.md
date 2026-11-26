# Finding files with find and xargs · 06 · Beirut family, tidying the scans of Teta's letters

Three cousins in Beirut scanned the letters in their grandmother's box from Achrafieh, one decade folder each. Their phones and scanners saved `.JPEG`, `.jpeg`, `.JPG` and `.jpg`, and two cousins scanned the same letter from Salim in Paris. One `find -exec sh -c` renames the whole batch without overwriting either Salim scan, and `-execdir` writes a caption beside every scan.

**What it teaches**

- `-exec sh -c '...' sh {} +` hands a batch of names to a small shell script, which loops over them with `for scan do`
- the word after the script (`sh`) becomes `$0`; leave it out and the first file is lost into `$0`
- `-execdir` runs the command inside each file's folder; GNU passes `./name` and BSD passes `name`, so strip the prefix with `${1#./}`
- test `[ -e "$target" ]` before `mv`: when two scans clean up to one name, GNU `mv -n` exits with an error and BSD `mv -n` stays quiet, so neither is a portable signal

**Lesson steps**

1. Count the names each sh -c call receives, with and without $0 (`find -exec sh -c`)
2. Rename a batch of scans to .jpg inside one sh -c loop (`find -exec sh -c`)
3. Check for an existing target before mv (`[ -e "$target" ]`)
4. Write a caption beside each scan with -execdir (`find -execdir`)

**Files**

| File | Role |
| --- | --- |
| [`tidy_scans.zsh`](tidy_scans.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/06-beirut-family-letters/tidy_scans.zsh
tests/run-examples.zsh 06-beirut-family-letters
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
