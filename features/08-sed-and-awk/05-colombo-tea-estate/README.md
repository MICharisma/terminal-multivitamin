# Editing streams with sed and awk · 05 · Colombo tea estate ledger

The Dimbola estate pays pluckers in rupees per kilogram. The field ledger is plain text on a shared Mac and a GNU/Linux VM. In-place renames must survive both `sed` flavors: `sed -i.bak` when a backup is welcome, and a one-time detect between GNU `sed -i` and BSD `sed -i ''` when it is not.

**What it teaches**

- `sed -i.bak` edits a file in place and leaves `file.bak` on both BSD and GNU sed
- GNU `sed -i` with no extension edits in place with no backup; BSD needs `sed -i ''`
- detecting GNU once with `sed --version` keeps one helper behind both behaviors

**Lesson steps**

1. Edit in place and keep `file.bak` (`sed -i.bak`)
2. Detect GNU sed once (`sed --version`)
3. Edit without a backup on either flavor (`sed -i ''`)

**Files**

| File | Role |
| --- | --- |
| [`tea_ledger.zsh`](tea_ledger.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/field-ledger.txt`](fixtures/field-ledger.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/05-colombo-tea-estate/tea_ledger.zsh
tests/run-examples.zsh 05-colombo-tea-estate
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
