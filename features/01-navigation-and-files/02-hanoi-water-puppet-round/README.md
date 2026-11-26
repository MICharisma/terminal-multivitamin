# Navigation and files · 02 · Hanoi water puppet theatre pre-show round

Before the evening show at a water puppet theatre in Hanoi, the stage manager checks three notes in three corners of the show folder: puppet repairs (Chú Tễu's grin needs repainting), the đàn bầu music cue, and a flickering lamp. `pushd` and `popd` let her visit each one and come back the way she came, without typing paths twice.

**What it teaches**

- `pushd` moves into a folder and remembers where you came from
- `$dirstack` is zsh's directory stack as an array; `:t` trims each entry
- `popd` walks back one stop at a time; `cd -` jumps to the previous folder
- `pushd -q` keeps the stack quiet so the script prints only what it means to

**Lesson steps**

1. Push into the puppet repairs folder (`pushd`)
2. Push two more stops and read the stack (`$dirstack`)
3. Pop back one stop at a time (`popd`)
4. Toggle between two folders with cd - (`cd -`)

**Files**

| File | Role |
| --- | --- |
| [`cue_round.zsh`](cue_round.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/02-hanoi-water-puppet-round/cue_round.zsh
tests/run-examples.zsh 02-hanoi-water-puppet-round
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
