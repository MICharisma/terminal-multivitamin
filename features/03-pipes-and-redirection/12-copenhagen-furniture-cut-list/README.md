# Pipes and redirection · 12 · Copenhagen furniture workshop, pasting a cut list

A furniture workshop in Copenhagen is building an oak sideboard for a café in Nørrebro. The cabinetmaker pipes the cut list into the clipboard to paste into an email to the timber yard, counts parts straight from the clipboard, and tidies it in place. `pbcopy` and `pbpaste` are macOS tools, so the Linux test job skips this one; the script restores whatever the clipboard held before.

**What it teaches**

- `pbcopy` reads stdin into the macOS clipboard; `pbpaste` writes the clipboard to stdout
- `cmd | pbcopy` copies a command's output, ready to paste into Mail or Numbers
- `pbcopy < file` copies a file without opening it; `pbpaste > file` saves the clipboard
- `pbpaste | sort -u | pbcopy` tidies whatever is on the clipboard in place
- saving the clipboard first and restoring it in the `EXIT` trap leaves it as the user had it

**Lesson steps**

1. Save the clipboard and restore it on exit (`trap ... | pbcopy`)
2. Copy a command's output to the clipboard (`| pbcopy`)
3. Pipe the clipboard into another command (`pbpaste |`)
4. Copy a file and paste it back (`pbcopy < file`)
5. Tidy the clipboard in place (`pbpaste | sort -u | pbcopy`)

**Files**

| File | Role |
| --- | --- |
| [`cut_list.zsh`](cut_list.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/12-copenhagen-furniture-cut-list/cut_list.zsh
tests/run-examples.zsh 12-copenhagen-furniture-cut-list
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`pbcopy` and `pbpaste`); on Linux it prints a message and exits 2, and the test runner skips it.
