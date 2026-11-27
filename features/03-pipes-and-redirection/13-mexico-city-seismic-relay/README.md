# Pipes and redirection · 13 · Mexico City seismic alert relay

Mexico City's seismic alert network relays accelerometer readings from stations across the valley. In this capstone a feed writes into a named pipe, a classifier reads from it, routine readings go straight to the screen, breaches are captured for the civil protection bulletin, and every reading lands in an audit log on a descriptor zsh picks itself.

**What it teaches**

- `mkfifo` makes a named pipe: a background writer and a reader meet there, and nothing piles up on disk
- opening a fifo waits until both ends are open; `wait $writer` collects the writer's exit status
- `exec {audit}>>audit.log` (zsh, bash 4.1+) picks a free descriptor and stores its number in `$audit`
- `$( cmd 2>&1 1>&$terminal )` captures only the warnings, while normal output goes to the saved stdout
- a here-doc loads the station thresholds; `{ ... } | tee` prints the bulletin and files it

**Lesson steps**

1. Load station thresholds from a here-doc (`done <<'EOF'`)
2. Start a writer on a named pipe (`mkfifo`)
3. Let zsh pick descriptors for the audit log and the terminal (`exec {fd}>file`)
4. Capture only the alerts while routine output passes through (`$( cmd 2>&1 1>&$fd )`)
5. Print the bulletin and file it with tee (`tee`)
6. Close the descriptors and check the pipe (`exec {fd}>&-`)

**Files**

| File | Role |
| --- | --- |
| [`seismic_relay.zsh`](seismic_relay.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/13-mexico-city-seismic-relay/seismic_relay.zsh
tests/run-examples.zsh 13-mexico-city-seismic-relay
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
