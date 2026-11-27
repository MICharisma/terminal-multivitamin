# Pipes and redirection · 08 · São Paulo samba school, one rehearsal notice for every wing

A samba school in São Paulo sends the same rehearsal notice to each of its wings (alas): the drummers of the bateria, the baianas, the passistas. zsh's `multios` writes one command's output to several files at once, sends it to a file and a pipe together, and reads several files as one input. Turn the option off and you are back to the sh rule.

**What it teaches**

- zsh's `multios`: `print notice > a > b > c` writes the same output to all three files
- `>> a >> b` appends to several files; `> file | cmd` writes to the file and the pipe at once
- `cat < a < b` reads several inputs one after another, like `cat a b`
- `setopt no_multios` restores the sh/bash rule: only the last redirection counts

**Lesson steps**

1. Write one notice to three files (`> a > b`)
2. Append to two of them (`>> a >> b`)
3. Write to a file and a pipe at once (`> file | cmd`)
4. Read two files as one input (`< a < b`)
5. Turn multios off and see only the last redirection win (`setopt no_multios`)

**Files**

| File | Role |
| --- | --- |
| [`rehearsal_notice.zsh`](rehearsal_notice.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/08-sao-paulo-samba-rehearsal/rehearsal_notice.zsh
tests/run-examples.zsh 08-sao-paulo-samba-rehearsal
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
