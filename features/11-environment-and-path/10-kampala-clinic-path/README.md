# Environment and PATH · 10 · Kampala clinic IT closet, refusing a dangerous PATH

The IT closet at a clinic in Kampala finds `.` and a world-writable folder on PATH. The script audits each entry with mode-bit arithmetic, drops the dangerous ones, and rewrites PATH so `clinic_ls` comes from the safe bin.

**What it teaches**

- a relative `.` on PATH means the current folder is searched for every command
- a world-writable directory on PATH lets anyone plant a trojan `ls`
- test with bit arithmetic on the directory mode, the same idea as the payments-key guard
- rewrite PATH to the safe entries only; do not merely warn

**Lesson steps**

1. Put . and a world-writable dir on PATH (`PATH`)
2. Audit each entry and drop the bad ones (`(( mode & 8#002 ))`)
3. Rewrite path to the safe entries (`path=( $safe_path )`)

**Files**

| File | Role |
| --- | --- |
| [`path_hygiene.zsh`](path_hygiene.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/10-kampala-clinic-path/path_hygiene.zsh
tests/run-examples.zsh 10-kampala-clinic-path
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
