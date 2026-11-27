# Searching text with grep · 06 · Kampala mobile-money agents, auditing the morning float

A mobile-money float desk in Kampala keeps one log per agent booth (Nakasero, Wandegeya, Kitintale). Recursive grep finds every FAILED withdrawal, lists the booths that saw one, lists the clean booths, and pulls a customer's number as bare lines.

**What it teaches**

- `grep -r pattern dir` searches every file under a folder (GNU and BSD both support `-r`)
- `grep -l` lists only the file names that matched; `grep -L` lists the ones that did not
- `-r` prefixes each hit with `file:`; `-h` hides the filename when you want bare lines
- recursive grep follows the tree; keep the folder small, or prefer `rg` for big trees

**Lesson steps**

1. Search every log under a folder (`grep -r`)
2. List only the files that matched (`grep -l`)
3. List the files that did not match (`grep -L`)
4. Hide filenames with -h (`grep -h`)

**Files**

| File | Role |
| --- | --- |
| [`float_audit.zsh`](float_audit.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/ledger/agent-kitintale.log`](fixtures/ledger/agent-kitintale.log) | Fixture copied into the script's temp folder |
| [`fixtures/ledger/agent-nakasero.log`](fixtures/ledger/agent-nakasero.log) | Fixture copied into the script's temp folder |
| [`fixtures/ledger/agent-wandegeya.log`](fixtures/ledger/agent-wandegeya.log) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/06-kampala-mobile-money/float_audit.zsh
tests/run-examples.zsh 06-kampala-mobile-money
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
