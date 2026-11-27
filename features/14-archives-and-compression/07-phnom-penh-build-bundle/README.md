# Archives and compression · 07 · Phnom Penh build bundle

A startup near the riverside ships a Node app to staging. `tar --exclude` keeps
`node_modules` out of `greet-kh.tgz`; `tar -tf` lists what actually made it in.

**What it teaches**

- `tar --exclude` skips heavy folders like `node_modules` while packing the rest
- `tar -tf` afterwards proves the excluded paths never entered the archive

**Lesson steps**

1. Pack the app while excluding node_modules (`tar --exclude`)
2. List the archive and confirm node_modules stayed out (`tar -tf`)

**Files**

| File | Role |
| --- | --- |
| [`bundle_release.zsh`](bundle_release.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/07-phnom-penh-build-bundle/bundle_release.zsh
tests/run-examples.zsh 07-phnom-penh-build-bundle
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
