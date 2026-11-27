# Permissions and ownership · 06 · Quito university, an exam drop folder students cannot browse

A physics lecturer at a university in Quito wants a hand-in folder for a midterm: students drop their answers in, can reopen their own file by name, and cannot list or copy each other's. Before settling on mode 300, the script tests five operations (list, enter, read, create, delete) against six folder modes and prints the matrix, which is the clearest way to see what `r`, `w` and `x` mean on a folder. It refuses to run as root, because root ignores these bits.

**What it teaches**

- on a folder, `r` lists names, `x` lets you through to the files inside, `w` creates and deletes
- `w` is useless without `x`: creating or deleting a name needs both
- `-wx` (mode 300) is a drop box: hand in a file, open it again by name, but never list the others
- `r` without `x` lists names, yet every file stays out of reach
- root ignores these bits, so the script refuses to run as root

**Lesson steps**

1. Write one small test per folder operation (`folder r w x`)
2. Try every operation against six folder modes (`folder mode matrix`)
3. See that w does nothing without x (`folder r w x`)
4. Hand in exams through a -wx drop box (`chmod 300`)

**Files**

| File | Role |
| --- | --- |
| [`folder_matrix.zsh`](folder_matrix.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/06-quito-exam-drop-folder/folder_matrix.zsh
tests/run-examples.zsh 06-quito-exam-drop-folder
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
