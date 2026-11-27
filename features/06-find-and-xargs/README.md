# Finding files with find and xargs

`find` walks a folder tree and evaluates an expression for every file it meets:
tests (`-name`, `-iname`, `-type`, `-size`, `-empty`, `-newer`, `-path`, `-regex`),
operators (`!`, `-o`, `\( \)`), and actions (`-print`, `-print0`, `-prune`, `-delete`,
`-exec`, `-execdir`). `xargs` turns lines, words, or NUL-separated names into the
arguments of another command, in batches (`-n`), per line (`-L`, `-I`), or in
parallel (`-P`). The slots below build from single tests up to a release manifest,
and show where names with spaces, apostrophes, and leading folders go wrong.

macOS ships BSD `find` and `xargs`; Linux ships GNU findutils. The basics agree, and
the slots point out each difference they hit:

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| Custom output (size, date, path) | no `-printf`; `-exec stat -f '%z %Sm %N' {} +` | `-printf '%s %TY-%Tm-%Td %p\n'` | detect once, or `-exec cksum {} +` |
| Extended regex | `find -E dir -regex ...` | `find dir -regextype posix-extended -regex ...` | detect once; two arrays |
| Name passed by `-execdir` | `name` | `./name` | `${1#./}` |
| Starting folder | required | defaults to `.` | always give one |
| Empty input to `xargs` | command not run | command run once (`-r` stops it) | `find ... -exec cmd {} +` never runs empty |
| `xargs -I {}` | replaces in up to 5 arguments (`-R`) | no cap | keep `{}` to a few arguments |
| Extended attributes | `-xattr`, `-xattrname name` | none | macOS only |
| `mv -n` onto an existing file | skips quietly, exit 0 | skips with a message, exit 1 | test `[ -e "$target" ]` first |

Habits that hold on both: put `-maxdepth` and `-mindepth` before any test, quote
every pattern (`-name '*.pdf'`, not `-name *.pdf`), group `-o` in `\( \)`, end a
`-prune` expression with `-print`, and pipe `find` to `sort` whenever the order
matters, because `find` lists in directory order.

[`fd`](https://github.com/sharkdp/fd) (`brew install fd`) is a friendlier
alternative for interactive searches: it skips hidden files and `.gitignore`d
folders by default and takes a regex directly (`fd '\.pdf$' repertorio`). It is not
installed by default anywhere, so the scripts here stick to `find`.

Official references: `man find` and `man xargs` on macOS, and the GNU findutils
manual (`info find`).

## Examples (13 of 13 built)

01. [Buenos Aires tango orchestra, pulling parts for rehearsal](01-buenos-aires-tango-parts/) — available
02. [Istanbul ferry engine logs since the dry-dock inspection](02-istanbul-ferry-engine-logs/) — available
03. [Dublin traditional music school, who is ready for the grade exam](03-dublin-trad-music-school/) — available
04. [Lagos film editing suite, clearing the render cache](04-lagos-editing-suite-cache/) — available
05. [Vancouver game studio, counting source without node_modules](05-vancouver-game-studio-prune/) — available
06. [Beirut family, tidying the scans of Teta's letters](06-beirut-family-letters/) — available
07. [Rotterdam container terminal, sizing crane telemetry dumps](07-rotterdam-crane-telemetry/) — available
08. [Bogotá university library, fixity checksums for the thesis repository](08-bogota-thesis-checksums/) — available
09. [Tallinn song festival, one folder per choir and song](09-tallinn-song-festival/) — available
10. [Stellenbosch wine estate, fermentation tank alarms, in portable sh](10-stellenbosch-cellar-alarms/) — available
11. [Seville flamenco academy, collecting rehearsal videos, in bash](11-seville-flamenco-videos/) — available
12. [Berlin techno label, clearing quarantine from sample packs](12-berlin-label-quarantine/) — available, macOS only
13. [Shenzhen electronics factory, firmware release manifest](13-shenzhen-firmware-release/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Tango orchestra (music) | `-name` vs `-iname`, `-type f`, `\( a -o b \)` precedence, `sort` for a stable order |
| 02 | Ferry line (mechanical) | `-newer` a reference file, `! -newer`, a `touch -t` date window, `cp` vs `cp -p` |
| 03 | Music school (education) | How `xargs` splits blanks and quotes, `-print0 \| xargs -0`, `-exec {} +` |
| 04 | Film editing suite (art) | `-size`, `-empty`, `-print` dry run, `-delete`, depth-first empty folders, `-delete` order trap |
| 05 | Game studio (tech) | `-prune -o ... -print`, the missing `-print` trap, `-path`, `-mindepth`/`-maxdepth` |
| 06 | Family | `-exec sh -c '...' sh {} +`, the `$0` placeholder, `-execdir` and `${1#./}`, collision-safe renames |
| 07 | Container terminal (mechanical) | GNU `-printf` vs BSD `stat -f`, detected once; ranking and per-crane totals |
| 08 | University library (education) | `xargs -n` batches, `xargs -P` with a sorted result, `cksum` manifests, `xargs -r` on empty input |
| 09 | Song festival (music) | `xargs` over plan files: plain vs `-L 1` vs `-I {}` |
| 10 | Wine estate (business) | POSIX `sh`: `-exec \;` vs `+`, the `/dev/null` file-name trick, exit status under `set -e` |
| 11 | Flamenco academy (art, education) | bash: pipe subshell trap, `read -r -d ''` with process substitution, bash 3.2 arrays |
| 12 | Record label (music, business) | macOS `find -xattrname`, `xargs -0 xattr -d`, `xattr -cr` |
| 13 | Electronics factory (mechanical, tech) | Capstone: `-regex` flavors, `-prune` + `-newer` + `-print0` in one function, `cksum` grouping |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
