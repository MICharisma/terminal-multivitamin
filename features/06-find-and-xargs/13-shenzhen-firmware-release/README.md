# Finding files with find and xargs · 13 · Shenzhen electronics factory, firmware release manifest

A factory in Bao'an, Shenzhen, builds e-bike motor controllers and battery management boards, and every firmware release goes to the assembly line with a manifest. The firmware folder also holds release candidates, linker maps, intermediate builds, a cache, and the images from the last release. One `find` expression keeps only the new release images, `xargs -0 cksum` writes the manifest, and the manifest shows that two board revisions got byte-identical images. The regex flag differs between BSD and GNU `find`, and even sits in a different place on the command line.

**What it teaches**

- `-regex` matches the whole path, not just the name, so patterns start with `.*/`
- extended regexes need `find -E dir` on BSD and `find dir -regextype posix-extended` on GNU: one flag goes before the paths, the other after, so the script keeps them in two arrays
- one function combines `-prune`, `-type f`, `-regex`, and `-newer` with `-print0`
- `xargs -0 cksum` turns the result into a manifest; a zsh associative array keyed by CRC spots board revisions that got byte-identical images

**Lesson steps**

1. Pick the regex flag for BSD or GNU find (`find -E / -regextype posix-extended`)
2. Match release images by full path with -regex (`find -regex`)
3. Prune build and cache copies and skip the last release (`find -prune -o -print`)
4. Write the manifest with xargs -0 cksum (`find -print0 | xargs -0`)
5. Group the manifest by CRC to spot identical images (`typeset -A`)

**Files**

| File | Role |
| --- | --- |
| [`release_manifest.zsh`](release_manifest.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/13-shenzhen-firmware-release/release_manifest.zsh
tests/run-examples.zsh 13-shenzhen-firmware-release
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux: BSD `find` gets `-E` before the paths, GNU `find` gets `-regextype posix-extended` after them.
