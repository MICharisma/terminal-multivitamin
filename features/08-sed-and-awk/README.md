# Editing streams with sed and awk

`sed` walks a line at a time: substitute with `s///`, address with line numbers or
patterns, delete or quiet-print with `-n`, and edit files in place with `-i`. `awk`
treats each line as fields: print columns, match patterns, run `BEGIN` and `END`
blocks, hold arrays, and format with `printf`. The slots below build from a single
substitution up to a palm-leaf archive capstone, and show where BSD and GNU `sed`
disagree on in-place edits.

macOS ships BSD `sed` and BSD `awk` (sometimes called `awk` or `nawk`); Linux ships
GNU `sed` and often `gawk`. The POSIX awk core is shared, and the slots flag each
`sed -i` difference they hit:

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| In-place edit, keep backup | `sed -i.bak 'cmd' file` | `sed -i.bak 'cmd' file` | `sed -i.bak` |
| In-place edit, no backup | `sed -i '' 'cmd' file` | `sed -i 'cmd' file` | detect once; see Colombo |
| Quit after line N | `sed -n '5{p;q;}'` | `sed -n '5q'` or `5{p;q;}` | `sed -n '5{p;q;}'` |
| Capture groups in `sed` | `\( \)` and `\1` | same on both | backslashes required |
| Extended regex in `sed` | `sed -E` | `sed -r` or `-E` | not used here |
| `awk` associative arrays | yes | yes | POSIX |
| `gensub`, `FPAT`, `PROCINFO` | no | gawk only | not used here |

Habits that hold on both: run a plain `sed 's///' file` before `sed -i`, quote every
address and delimiter, keep `LC_ALL=C` when order and character classes matter, and
prefer `sed -i.bak` when a backup is acceptable on every machine.

Official references: `man sed`, `man awk` on macOS, and the GNU sed and gawk manuals.

## Examples (13 of 13 built)

01. [Fez pottery glaze recipes](01-fez-pottery-glaze-recipes/) — available
02. [Yangon ferry timetable](02-yangon-ferry-timetable/) — available
03. [Quito orchid nursery export](03-quito-orchid-nursery/) — available
04. [Antwerp diamond inventory](04-antwerp-diamond-inventory/) — available
05. [Colombo tea estate ledger](05-colombo-tea-estate/) — available
06. [Bratislava marionette theatre](06-bratislava-marionette-theatre/) — available
07. [Dakar fishing cooperative](07-dakar-fishing-cooperative/) — available
08. [Valparaíso funicular logs](08-valparaiso-funicular-logs/) — available
09. [Muscat date farm grades](09-muscat-date-farm-grades/) — available
10. [Lyon silk weaving](10-lyon-silk-weaving/) — available
11. [Hobart Antarctic logistics](11-hobart-antarctic-logistics/) — available
12. [Sapporo snow festival LEDs](12-sapporo-snow-festival-leds/) — available, macOS only
13. [Vientiane temple palm-leaf archive](13-vientiane-temple-palm-leaf-archive/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Pottery atelier (art) | `s///` first match vs `g`, several `sed -e` in one stream |
| 02 | Ferry line (mechanical) | line numbers, `/pattern/`, and `/from/,/to/` ranges |
| 03 | Orchid nursery (education) | `-n` quiet mode, `d`, `!` invert, early quit with `{p;q;}` |
| 04 | Diamond trade (business) | `\( \)` captures, `\1`, `&`, and a `case` router per lab |
| 05 | Tea estate (business) | `sed -i.bak` on both flavors; detect GNU vs BSD for no backup |
| 06 | Marionette theatre (art) | `print $n`, `-F`, `OFS`, `NF` |
| 07 | Fishing cooperative (family) | `/regex/` actions, numeric comparisons, `END` totals in a function |
| 08 | Funicular operator (mechanical) | `BEGIN`/`END`, numeric arrays, `length` on arrays and strings |
| 09 | Date farm (business) | `awk printf`, column width, `%.2f`, zsh `typeset -A` handoff |
| 10 | Silk weaving (art) | associative `++` and `+=`, `for (k in arr)`, `case` over roles |
| 11 | Antarctic logistics (tech) | bash `sed \| awk`, process substitution, here-string |
| 12 | Snow festival (music) | macOS `sed -i ''` with no backup; dry run first |
| 13 | Temple archive (education) | Capstone: `sed` tag transliteration, `awk` field repair, shelf totals |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.