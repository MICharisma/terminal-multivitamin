# Archives and compression

Packing trees into archives and squeezing single files: `tar`, `zip`/`unzip`,
`gzip`, `xz`, checksums with `shasum`, and macOS `ditto` for Finder-friendly
zips. The slots below stay portable across BSD and GNU where the tools exist,
and mark the one that needs macOS.

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| Create a gzipped tar | `tar -czf a.tgz files` | same | `tar -czf a.tgz files` |
| List tar members by name | `tar -tf a.tgz` | same | prefer `-tf` over `-tvf` (uids/dates vary) |
| Extract a tar | `tar -xzf a.tgz` | same | `tar -xzf a.tgz` / `tar -xzf a.tgz member` |
| SHA-256 checksum | `shasum -a 256` | `sha256sum` or `shasum` | `shasum -a 256` |
| Zip names only | `unzip -Z1 a.zip` | same | `unzip -Z1` (avoid date columns in `-l`) |
| Finder zip | `ditto -c -k` | (no ditto) | macOS only |

Official references: `man tar`, `man zip`, `man gzip`, `man xz`, `man shasum`,
and on macOS `man ditto`.

## Examples (13 of 13 built)

01. [Palermo festa birthday photos](01-palermo-festa-photos/) — available
02. [Almaty university course pack](02-almaty-course-pack/) — available
03. [Busan shipping documents](03-busan-shipping-docs/) — available
04. [Quito mural restoration logs](04-quito-mural-logs/) — available
05. [Tunis oud recording stems](05-tunis-oud-stems/) — available
06. [Bremen spare-parts checksum](06-bremen-parts-checksum/) — available
07. [Phnom Penh build bundle](07-phnom-penh-build-bundle/) — available
08. [Recife carnival office update](08-recife-carnival-update/) — available
09. [Ulaanbaatar core sample archive](09-ulaanbaatar-core-sample/) — available
10. [Cork lab datasets](10-cork-lab-datasets/) — available
11. [Medellín gallery zip](11-medellin-gallery-unzip/) — available
12. [Fukuoka score zip](12-fukuoka-score-zip/) — available, macOS only
13. [Sarajevo ballot bundle](13-sarajevo-ballot-bundle/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Family | one-shot `tar -czf` and name-only `tar -tf` |
| 02 | University (education) | `tar -xzf` into a tree, then list what landed |
| 03 | Freight desk (business) | `zip -r` / `unzip` roundtrip of a folder |
| 04 | Mural studio (art) | `for` loop `gzip` each log, then `gzip -d` one |
| 05 | Recording room (music) | `xz` / `xz -d`, compare sizes without pinning xz version bytes |
| 06 | Machine shop (mechanical) | `shasum -a 256` manifest and `shasum -c` verify |
| 07 | Startup (tech) | `tar --exclude` skipping `node_modules`-like dirs |
| 08 | Carnival office (business) | `while read` plan, `zip` then `zip -u` |
| 09 | Geology lab (science) | `tar -tf` inventory, `tar -xOf` one member to stdout |
| 10 | Research lab (education) | associative array of datasets, gzip each copy |
| 11 | Gallery (art) | `unzip -Z1` listing, selective `unzip` of one file |
| 12 | Conservatory (music) | macOS `ditto -c -k` / `ditto -x -k` |
| 13 | Election board (government) | function workflow: pack, checksum, verify, extract |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
