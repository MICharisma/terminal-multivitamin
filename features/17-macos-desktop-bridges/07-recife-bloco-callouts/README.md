# macOS desktop bridges · 07 · Recife bloco rehearsal callouts

Bloco da Torre in Recife keeps short Portuguese callouts for street rehearsals. An associative array maps voice to line; under the headless guard the script prints `would: say -v ...` instead of speaking, iterating with `${(kv)callouts}`.

**What it teaches**

- an associative array holds voice → callout pairs
- `for voice line in ${(kv)callouts}` walks keys and values together
- `say -v` picks a macOS voice; headless mode prints the command instead of playing audio

**Lesson steps**

1. Walk voice and callout pairs together (`${(kv)array}`)
2. Speak each callout with a named voice (`say -v`)
3. Keep CI quiet with the headless guard (`headless guard`)

**Files**

| File | Role |
| --- | --- |
| [`bloco_callouts.zsh`](bloco_callouts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/07-recife-bloco-callouts/bloco_callouts.zsh
tests/run-examples.zsh 07-recife-bloco-callouts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
