# Pipes and redirection · 03 · Istanbul ferry engine room, comparing both engines

On a Bosphorus ferry between Eminönü and Kadıköy, the engine room logs the port and starboard engine speeds on every crossing, one file per engine. The chief engineer reads the first line, finds the peak, and walks both logs in step to spot crossings where the engines drift apart, a sign of a fouled propeller or a tired governor.

**What it teaches**

- `< file` connects a file to a command's stdin; `read line < file` takes just the first line
- `while read ...; done < file` feeds the whole loop, and its variables survive the loop (in bash they would not survive `cat file | while read`; redirect the loop instead)
- `exec 3< a 4< b` opens extra input descriptors, so one loop can read two files in step
- `read -u 3` reads from descriptor 3 (portable form: `read -r line <&3`); `exec 3<&-` closes it

**Lesson steps**

1. Read the first crossing with < and read (`<`)
2. Feed a whole loop from a file and keep its variables (`done < file`)
3. Open both logs on descriptors 3 and 4 (`exec 3< file`)
4. Read both engines in step (`read -u`)
5. Close the descriptors (`exec 3<&-`)

**Files**

| File | Role |
| --- | --- |
| [`engine_watch.zsh`](engine_watch.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/port-engine.log`](fixtures/port-engine.log) | Fixture copied into the script's temp folder |
| [`fixtures/starboard-engine.log`](fixtures/starboard-engine.log) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/03-istanbul-ferry-engine-room/engine_watch.zsh
tests/run-examples.zsh 03-istanbul-ferry-engine-room
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
