# Pipes and redirection · 02 · Buenos Aires milonga DJ, building tandas

A DJ at a milonga in Palermo builds tandas (sets of three or four tangos by one orchestra) from a music library. Her helper prints the tracks it finds on stdout and complains about missing ones on stderr, like any well-behaved Unix tool. Each redirection sends those two streams somewhere different, and the order of `2>&1` decides where.

**What it teaches**

- every command has two output streams: stdout (1) for results, stderr (2) for complaints
- `> list 2> warnings` sends each stream to its own file; `2>/dev/null` drops the complaints
- `> file 2>&1` puts both streams in the file; `2>&1 > file` does not, because redirections are applied left to right
- `2>&1 >/dev/null |` sends only stderr down the pipe in bash; zsh's `multios` also copies stdout into the pipe unless the command is wrapped in `{ }`
- zsh's `|&` (bash 4+ too) is short for `2>&1 |`

**Lesson steps**

1. Show both streams together on the terminal (`2>&1`)
2. Send the playlist and the warnings to separate files (`2> file`)
3. Drop the warnings with /dev/null (`2>/dev/null`)
4. Compare > file 2>&1 with 2>&1 > file (`> file 2>&1`)
5. Count only the missing records, and meet zsh's multios (`2>&1 >/dev/null |`)

**Files**

| File | Role |
| --- | --- |
| [`build_tandas.zsh`](build_tandas.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/02-buenos-aires-milonga-tandas/build_tandas.zsh
tests/run-examples.zsh 02-buenos-aires-milonga-tandas
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
