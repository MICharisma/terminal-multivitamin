# Finding files with find and xargs · 09 · Tallinn song festival, one folder per choir and song

The music office of the Estonian song festival in Tallinn sends each choir its parts, filed by choir and voice, and keeps a folder per song for the joint score. The roster and the song list are plain text files, one entry per line, so `xargs` turns them into commands without any `find`. Song titles such as "Mu isamaa armas" have spaces, which is where `-L 1` and `-I {}` part ways.

**What it teaches**

- `xargs` is not only for `find`: it turns the lines of any plan file into arguments
- `xargs -L 1` runs one command per line, still splitting that line into words
- `xargs -I {}` takes each whole line, spaces included, and drops it wherever `{}` appears
- plain `xargs mkdir` splits "Mu isamaa armas" into three folders
- BSD `xargs -I` replaces `{}` in at most five arguments (`-R`); GNU has no such cap

**Lesson steps**

1. See plain xargs split song titles into words (`xargs`)
2. Make a folder per choir and voice, one roster line per command (`xargs -L 1`)
3. Make a folder per song, keeping each whole line (`xargs -I {}`)
4. Use the placeholder twice to copy the joint score (`xargs -I {}`)

**Files**

| File | Role |
| --- | --- |
| [`choir_folders.zsh`](choir_folders.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/09-tallinn-song-festival/choir_folders.zsh
tests/run-examples.zsh 09-tallinn-song-festival
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
