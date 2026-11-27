# Pipes and redirection · 05 · Lagos family splitting a hospital bill

Four siblings in Lagos are splitting their mother's bill from Lagos University Teaching Hospital, and the payments arrive as WhatsApp messages: "Ngozi: sent ₦310,000, receipt attached". Every piece of text is already in a variable, so here-strings feed it to `tr`, `wc`, `grep`, and `read` without an `echo |` or a temp file.

**What it teaches**

- a here-string (`cmd <<< "$text"`) feeds one string to stdin, with no `echo |` and no temp file
- `IFS=: read -r name note <<< "$message"` splits a string into variables in the current shell
- a here-string adds a newline: `wc -c <<< "$ref"` counts one more byte than the text
- `tr -dc '0-9' <<< "₦1,240,000"` keeps only the digits, so `(( ))` can add naira amounts
- `grep -c` and `read -A` (zsh) work on a multi-line string the same way

**Lesson steps**

1. Keep only the digits of a naira amount (`<<<`)
2. See the newline a here-string adds (`wc -c <<<`)
3. Count messages and payments in a multi-line string (`grep -c <<<`)
4. Split each message into name and note (`IFS=: read -r <<<`)
5. Read words into a zsh array (`read -A <<<`)

**Files**

| File | Role |
| --- | --- |
| [`split_bill.zsh`](split_bill.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/05-lagos-hospital-bill-split/split_bill.zsh
tests/run-examples.zsh 05-lagos-hospital-bill-split
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
