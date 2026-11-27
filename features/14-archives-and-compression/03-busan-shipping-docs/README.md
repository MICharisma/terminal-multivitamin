# Archives and compression · 03 · Busan shipping documents

A freight clerk at the Busan New Port desk packs bills of lading and certificates
into one zip for the Rotterdam agent. She hashes the bill before `zip -r`, removes
the folder, then `unzip`s and checks the hash still matches.

**What it teaches**

- `zip -r` packs a whole folder tree into a zip archive
- `unzip` restores the tree; comparing content before and after proves the roundtrip

**Lesson steps**

1. Record the bill of lading checksum before packing (`shasum -a 256`)
2. Zip the whole shipment folder tree (`zip -r`)
3. Unzip and confirm the bill of lading survived (`unzip`)

**Files**

| File | Role |
| --- | --- |
| [`shipping_roundtrip.zsh`](shipping_roundtrip.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/03-busan-shipping-docs/shipping_roundtrip.zsh
tests/run-examples.zsh 03-busan-shipping-docs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
