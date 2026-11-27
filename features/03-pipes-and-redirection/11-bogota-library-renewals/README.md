# Pipes and redirection · 11 · Bogotá university library, renewing loans in a batch

The circulation desk at a university library in Bogotá renews a batch of loans from a list of student IDs and call numbers. The first attempt renews one book and stops: the renewal client, like `ssh` and many other tools, reads stdin, and inside the loop stdin is the rest of the list. `/dev/null` and a separate descriptor fix it.

**What it teaches**

- a command inside `while read ...; done < file` shares the loop's stdin, and can swallow the rest of the file (ssh, ffmpeg, and many CLIs that read input do exactly this)
- `< /dev/null` gives such a command an empty stdin; reading the loop from descriptor 3 (`read -u 3 ... done 3< file`) leaves stdin alone altogether
- `> /dev/null 2>&1` throws output away when only the exit status matters
- `: > file` empties a file in place, keeping its permissions

**Lesson steps**

1. Watch a command swallow the rest of the loop's input (`done < file`)
2. Empty the log in place (`: > file`)
3. Give the command an empty stdin (`< /dev/null`)
4. Read the loop from descriptor 3 instead (`read -u 3 ... done 3< file`)
5. Keep only the exit status (`> /dev/null 2>&1`)

**Files**

| File | Role |
| --- | --- |
| [`renew_loans.zsh`](renew_loans.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/11-bogota-library-renewals/renew_loans.zsh
tests/run-examples.zsh 11-bogota-library-renewals
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
