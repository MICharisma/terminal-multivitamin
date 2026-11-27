# Editing streams with sed and awk · 11 · Hobart Antarctic logistics

The AAD warehouse in Hobart tags container lines with `TAG-SKU` before piping them to the manifest printer. Bash strips the tag with `sed`, totals kilograms per Antarctic station with `awk`, lists heavy lines through process substitution, and picks the heaviest row with a here-string.

**What it teaches**

- `sed` can strip shipment tags before `awk` totals a column
- process substitution `< <(cmd)` feeds a pipeline into a second command without a temp file
- a here-string `cmd <<< data` is enough when the input is one small blob

**Lesson steps**

1. Strip tags then total with awk (`sed | awk`)
2. Feed a pipeline through process substitution (`< <(sed`)
3. Run awk on a here-string of cleaned lines (`awk <<<`)

**Files**

| File | Role |
| --- | --- |
| [`cargo_manifest.bash`](cargo_manifest.bash) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/container-lines.txt`](fixtures/container-lines.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/11-hobart-antarctic-logistics/cargo_manifest.bash
tests/run-examples.zsh 11-hobart-antarctic-logistics
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux with bash.
