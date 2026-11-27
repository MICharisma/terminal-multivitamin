# Archives and compression · 13 · Sarajevo ballot bundle

An election board clerk in Centar packs station tallies into one sealed bundle.
Four small functions wrap `tar -czf`, `shasum -a 256`, `shasum -c`, and
`tar -xzf` so pack → seal → verify → extract is one readable workflow.

**What it teaches**

- a small function library packs, checksums, verifies, and extracts one bundle
- `tar -czf` plus `shasum -a 256` seal the ballots; verify before `tar -xzf`

**Lesson steps**

1. Define pack_ballots around tar -czf (`tar -czf`)
2. Define seal_bundle around shasum -a 256 (`shasum -a 256`)
3. Define verify_bundle around shasum -c (`shasum -c`)
4. Define extract_ballots around tar -xzf (`tar -xzf`)
5. Run pack, seal, verify, and extract for election night (`tar -czf`)

**Files**

| File | Role |
| --- | --- |
| [`ballot_bundle.zsh`](ballot_bundle.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/13-sarajevo-ballot-bundle/ballot_bundle.zsh
tests/run-examples.zsh 13-sarajevo-ballot-bundle
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
