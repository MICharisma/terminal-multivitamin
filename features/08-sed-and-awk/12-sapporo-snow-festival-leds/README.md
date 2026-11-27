# Editing streams with sed and awk · 12 · Sapporo snow festival LEDs

Odori Park ice blocks drive addressable LED strings mapped in a plain-text channel list. On macOS the lighting crew retunes colour names with BSD `sed -i ''`, which needs the empty string argument GNU `sed` does not use. A stdout dry run precedes each in-place patch.

**What it teaches**

- on macOS, BSD `sed -i '' 'cmd' file` edits in place with no backup file
- GNU `sed -i 'cmd'` needs no empty argument; this slot stays on BSD intentionally
- patching channel names in place is safer with a dry run through bare `sed` first

**Lesson steps**

1. Preview a substitution on stdout (`sed 's/from/to/'`)
2. Patch in place with BSD `sed -i ''` (`sed -i ''`)
3. Retune a second channel the same way (`sed -i ''`)

**Files**

| File | Role |
| --- | --- |
| [`led_strings.zsh`](led_strings.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/ice-sculpture-map.txt`](fixtures/ice-sculpture-map.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/12-sapporo-snow-festival-leds/led_strings.zsh
tests/run-examples.zsh 12-sapporo-snow-festival-leds
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. Requires macOS: it exits 2 elsewhere.
