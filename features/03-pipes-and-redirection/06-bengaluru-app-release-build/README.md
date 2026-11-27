# Pipes and redirection · 06 · Bengaluru delivery app, keeping the release build log

A food-delivery startup in Bengaluru builds its Android app every evening. The build prints a stream of module lines and warnings; the team wants the full log kept, the warnings counted, a history across builds, and copies of the warnings for both app-store release notes. `tee` does all four without running the build twice.

**What it teaches**

- `tee file` writes its input to a file and passes it on, so a pipeline can keep going
- `tee` in the middle of a pipeline saves each stage, which is how you debug a long one
- `tee -a` appends instead of truncating, for a history across builds
- `tee one two >/dev/null` copies to several files and shows nothing
- (outside these scripts) `print ... | sudo tee /etc/file` is why `tee` shows up in setup guides: `sudo print > /etc/file` would open the file as you, not as root

**Lesson steps**

1. Keep the full log while counting warnings (`tee`)
2. Save each stage of a pipeline to debug it (`tee stage | cmd`)
3. Append to a history across builds (`tee -a`)
4. Copy to two files and print nothing (`tee a b >/dev/null`)

**Files**

| File | Role |
| --- | --- |
| [`release_build.zsh`](release_build.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/06-bengaluru-app-release-build/release_build.zsh
tests/run-examples.zsh 06-bengaluru-app-release-build
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
