# Archives and compression · 06 · Bremen spare-parts checksum

A machine shop on the Weser seals each drawing before a crate leaves for the
shipyard. `shasum -a 256` builds `SHA256SUMS`; `shasum -c` confirms the crate,
and the same check flags a gasket drawing that someone rewrote quietly.

**What it teaches**

- `shasum -a 256` writes a portable SHA-256 digest for each part drawing
- `shasum -c` reads the manifest and reports OK or FAILED per line

**Lesson steps**

1. Write a SHA-256 manifest for every part drawing (`shasum -a 256`)
2. Verify the intact crate against the manifest (`shasum -c`)
3. Catch a quiet edit when the gasket drawing changes (`shasum -c`)

**Files**

| File | Role |
| --- | --- |
| [`verify_parts.zsh`](verify_parts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/06-bremen-parts-checksum/verify_parts.zsh
tests/run-examples.zsh 06-bremen-parts-checksum
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
