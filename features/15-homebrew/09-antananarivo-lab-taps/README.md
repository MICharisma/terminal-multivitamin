# Homebrew · 09 · Antananarivo CS lab taps

The University of Antananarivo CS lab images iMacs with a Brewfile that adds `dart-lang/dart` and font casks. Staff list current taps, parse the Brewfile, and unique the union before imaging — still no `brew tap` writes.

**What it teaches**

- `brew tap` with no arguments lists every tapped repository
- a Brewfile's `tap "..."` lines name third-party sources the lab relies on
- `${(u)array}` uniques the combined list so imaging scripts do not retap

**Lesson steps**

1. List taps already on the lab iMac (`brew tap`)
2. Collect tap lines from the lab Brewfile (`Brewfile`)
3. Unique the union of installed and declared taps (`brew tap`)

**Files**

| File | Role |
| --- | --- |
| [`list_taps.zsh`](list_taps.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew tap` and the lab Brewfile |

**Try it**

From the repository root:

```sh
features/15-homebrew/09-antananarivo-lab-taps/list_taps.zsh
tests/run-examples.zsh 09-antananarivo-lab-taps
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
