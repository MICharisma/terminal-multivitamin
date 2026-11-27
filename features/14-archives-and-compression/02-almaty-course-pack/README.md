# Archives and compression · 02 · Almaty university course pack

A teaching assistant at Kazakh National University receives `course-pack.tgz`
before term starts. She extracts it with `tar -xzf` and checks that syllabus,
readings, and labs landed in the right folders.

**What it teaches**

- `tar -xzf` extracts a gzipped archive into the current folder
- after extract, a plain tree listing shows what the pack delivered

**Lesson steps**

1. Extract the course pack into the unpacked folder (`tar -xzf`)
2. List the syllabus, readings, and labs that landed (`tar -xzf`)

**Files**

| File | Role |
| --- | --- |
| [`unpack_course.zsh`](unpack_course.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/02-almaty-course-pack/unpack_course.zsh
tests/run-examples.zsh 02-almaty-course-pack
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
