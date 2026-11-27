# Searching text with grep

Finding lines (and pieces of lines) that match a pattern. This feature covers
plain `grep`, fixed strings (`-F`), extended regex (`-E`), Perl regex (`-P` where
GNU provides it), case and word boundaries (`-i` `-w`), inversion and counting
(`-v` `-c`), line numbers and only-matching (`-n` `-o`), recursive search
(`-r` `-l` `-L` `-h`), context (`-A` `-B` `-C`), multiple patterns (`-e` `-f`),
GNU `--include`/`--exclude` with a BSD fallback, a note on `ripgrep`, and
macOS Spotlight (`mdfind`/`mdls`) as a content index that is *not* a substitute
for grep on fresh files.

BSD (macOS) vs GNU (Linux) at a glance:

| Idea | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| Extended regex | `grep -E` | `grep -E` | `grep -E` |
| Fixed string | `grep -F` | `grep -F` | `grep -F` |
| Perl regex | no `-P` | `grep -P` | detect, or use `rg --pcre2` |
| Recursive + filter by name | no `--include` | `--include`/`--exclude` | `find … -exec grep` |
| Recursive | `grep -r` | `grep -r` | `grep -r` |

`ripgrep` (`rg`) is a separate tool: faster recursive search, respects
`.gitignore`, and offers `--pcre2` for Perl regex on every platform where it is
installed (`brew install ripgrep` / `apt install ripgrep`).

Official references: `man grep` on both platforms, `man mdfind` / `man mdls` on
macOS, and `rg --help`.

## Examples (13 of 13 built)

01. [Addis Ababa coffee exchange, searching the cupping notes](01-addis-ababa-cupping-notes/) — available
02. [Porto wine lodge, finding bottles in the inventory](02-porto-wine-lodge/) — available
03. [Chiang Mai lacquer atelier, filtering this week's orders](03-chiang-mai-lacquer-orders/) — available
04. [Belfast primary school, reading today's attendance](04-belfast-attendance/) — available
05. [Valparaíso cueca archive, indexing the verses](05-valparaiso-cueca-archive/) — available
06. [Kampala mobile-money agents, auditing the morning float](06-kampala-mobile-money/) — available
07. [Yangon family, comparing two mohinga recipes](07-yangon-mohinga-recipes/) — available
08. [Bratislava tram depot, matching fault codes literally](08-bratislava-tram-faults/) — available
09. [Quito university thesis, scanning citations](09-quito-thesis-refs/) — available
10. [Tunis mosaic workshop, searching only the palette files](10-tunis-mosaic-palette/) — available
11. [Phnom Penh irrigation logs, Perl regex and ripgrep notes, in bash](11-phnom-penh-irrigation-logs/) — available
12. [Colombo tea export desk, grading the catalogue, in portable sh](12-colombo-tea-export/) — available
13. [Auckland youth orchestra, finding parts with Spotlight](13-auckland-sheet-music/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Coffee exchange (business) | Plain `grep`, `-c`, basic regex `.`, exit status 1 |
| 02 | Wine lodge (business) | `-i`, `-w`, `-iw` |
| 03 | Lacquer atelier (art) | `-E` alternation, groups, `{2,}` |
| 04 | Primary school (education) | `-v`, stacked filters, `-c` / `-vc` |
| 05 | Folk archive (music) | `-n`, `-o`, `-no`, `-Eo` |
| 06 | Mobile money (tech) | `-r`, `-l`, `-L`, `-h` |
| 07 | Family | `-A`, `-B`, `-C`, `-nA` |
| 08 | Tram depot (mechanical) | `-F` vs character classes and metacharacters |
| 09 | University (education) | `-e`, `-f`, `-Ff` |
| 10 | Mosaic workshop (art) | GNU `--include`/`--exclude`, BSD `find` fallback |
| 11 | Irrigation (mechanical, government) | bash: `-P` detection, lookbehind, `rg` note |
| 12 | Tea export (business) | POSIX `sh`: `-x`, `-F -e`, `-v`, `grep -q` |
| 13 | Youth orchestra (music) | macOS `mdfind`/`mdls` vs immediate `grep -rl` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
