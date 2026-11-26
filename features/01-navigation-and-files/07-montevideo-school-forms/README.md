# Navigation and files · 07 · Montevideo school office sorting parents' attachments

The office of a public primary school in Montevideo collects permission slips, ID photos and absence notes from parents' phones. The file names lie: a PDF ends in `.jpg`, a photo ends in `.pdf`, a note ends in `.doc`. `file --mime-type` reads the bytes and a `case` statement files each one in the right folder.

**What it teaches**

- `file -b --mime-type` reads a file's contents, not its (often wrong) extension
- a `case` statement routes each MIME type to a folder
- `mkdir -p` inside the loop creates a destination only when it is needed
- `mv --` moves into a folder, keeping the original name

**Lesson steps**

1. Read each attachment's real type from its bytes (`file --mime-type`)
2. Route each type to a folder (`case`)
3. Create the folder on demand and move the file in (`mv`)
4. Confirm the inbox is empty (`ls -A`)

**Files**

| File | Role |
| --- | --- |
| [`sort_inbox.zsh`](sort_inbox.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/07-montevideo-school-forms/sort_inbox.zsh
tests/run-examples.zsh 07-montevideo-school-forms
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
