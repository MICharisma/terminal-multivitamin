# Environment and PATH · 07 · Yangon puppet theatre, loading the evening show from a .env file

A puppet theatre in Yangon keeps the evening show in a `.env` file. `set -a` turns on allexport, `. ./show.env` loads it, `set +a` turns it off, and a child process sees `SHOW_TITLE` without a per-line `export`.

**What it teaches**

- `set -a` (allexport) exports every assignment that follows until `set +a`
- `. ./show.env` (or `source`) runs the file in the current shell so the assignments stick
- wrap the source in `set -a` / `set +a` so only the file's names are exported, not later locals
- a child process then sees `SHOW_TITLE` without an explicit `export` per line

**Lesson steps**

1. Turn on allexport (`set -a`)
2. Source the show.env file (`. ./file`)
3. See the child inherit SHOW_TITLE (`export`)
4. Confirm later locals are not exported (`set +a`)

**Files**

| File | Role |
| --- | --- |
| [`load_env.zsh`](load_env.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/show.env`](fixtures/show.env) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/07-yangon-puppet-env/load_env.zsh
tests/run-examples.zsh 07-yangon-puppet-env
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
