# Finding files with find and xargs · 03 · Dublin traditional music school, who is ready for the grade exam

At a traditional music school in Dublin, teachers leave a note beside each pupil's recording, in a folder named after the pupil: `aoife ni bhriain`, `sean o'neill`, `ciaran byrne`. Before the grade exams the head of the school lists the tunes marked "ready for grade exam". Spaces and an apostrophe are ordinary in Irish names, and both break a plain `find | xargs`.

**What it teaches**

- `xargs` splits its input on blanks and newlines, so `ciaran byrne/the silver spear.txt` arrives as four arguments
- `xargs` also reads quotes as quoting, so the apostrophe in `sean o'neill` stops it with an error
- `find -print0 | xargs -0` separates names with NUL bytes, the one byte a file name cannot hold
- `find -exec grep -l ... {} +` batches names the way `xargs` does, with no parsing at all

**Lesson steps**

1. Watch xargs split one path with spaces into four arguments (`xargs`)
2. See the apostrophe in sean o'neill stop plain xargs (`xargs`)
3. Pass names with NUL bytes using -print0 and -0 (`find -print0 | xargs -0`)
4. Get the same list from -exec ... {} + with no xargs (`find -exec {} +`)

**Files**

| File | Role |
| --- | --- |
| [`exam_ready.zsh`](exam_ready.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/03-dublin-trad-music-school/exam_ready.zsh
tests/run-examples.zsh 03-dublin-trad-music-school
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
