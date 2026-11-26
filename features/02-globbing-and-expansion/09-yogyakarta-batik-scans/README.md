# Globbing and expansion · 09 · Yogyakarta batik studio, naming web images from scans

A batik studio in Yogyakarta scanned its parang, kawung and truntum motifs as high-resolution TIFFs. For the web shop each needs a short JPEG name in a folder per motif family. Path modifiers (`:t`, `:h`, `:r`, `:e`, `:s`) build the export plan without a single call to `basename` or `sed`.

**What it teaches**

- modifiers `:t` (tail), `:h` (head), `:r` (root, no extension), `:e` (extension)
- a modifier inside a glob qualifier, `*.tif(:t:r)`, changes every match
- modifiers on an unquoted array apply to each element; `(u)` drops duplicates
- `:s/old/new/` substitutes inside each name

**Lesson steps**

1. Pull a path apart with :h :t :r :e (`:t :h :r :e`)
2. Apply modifiers to every match inside the qualifier (`(:t:r)`)
3. List the motif families once each (`(u)`)
4. Substitute inside names to plan web exports (`:s/old/new/`)

**Files**

| File | Role |
| --- | --- |
| [`web_names.zsh`](web_names.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/09-yogyakarta-batik-scans/web_names.zsh
tests/run-examples.zsh 09-yogyakarta-batik-scans
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
