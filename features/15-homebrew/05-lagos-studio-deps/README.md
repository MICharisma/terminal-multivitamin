# Homebrew · 05 · Lagos highlife studio dependency map

A highlife recording studio on Lagos Island standardises on ffmpeg, sox, and lame. Before wiping a borrow-laptop, the engineer maps `brew deps` and `brew uses` into an associative array so shared libraries are not uninstalled by mistake.

**What it teaches**

- `brew deps FORMULA` lists what that formula needs
- `brew uses FORMULA` lists installed formulae that pull it in
- an associative array (`typeset -A`) holds the dependency map for a studio machine

**Lesson steps**

1. List dependencies for each studio formula (`brew deps`)
2. List installed formulae that use each shared library (`brew uses`)
3. Print the dependency map from an associative array (`typeset -A`)

**Files**

| File | Role |
| --- | --- |
| [`deps_map.zsh`](deps_map.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew` answering deps and uses |

**Try it**

From the repository root:

```sh
features/15-homebrew/05-lagos-studio-deps/deps_map.zsh
tests/run-examples.zsh 05-lagos-studio-deps
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
