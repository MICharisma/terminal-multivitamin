# Navigation and files

Moving around the filesystem and handling files: `cd`, `pwd`, `pushd`/`popd`, `ls`,
`mkdir`, `touch`, `cp`, `mv`, `rm`, `rmdir`, `ln`, `head`/`tail`/`wc`/`cat`, `stat`,
`file`, `du`, and `diff -r`, plus the zsh extras that make navigation fast:
`cdpath`, two-argument `cd`, `$dirstack`, and named directories.

macOS ships BSD versions of these tools, and Linux ships GNU versions. Most flags
agree, but not all of them, and the slots below point out each difference they hit:

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| File size in bytes | `stat -f %z f` | `stat -c %s f` | `wc -c < f`, or zsh `zstat +size f` |
| Copy a folder's contents | `cp -R src/ dest` | `cp -R src/. dest` | `cp -R src/. dest/` |
| Line count | `wc -l` pads with spaces | `wc -l` doesn't pad | `$(( $(wc -l < f) ))` |
| Replace a symlink to a folder | `ln -sfn` (or `-sfh`) | `ln -sfn` | `ln -sfn` |
| Show file flags | `ls -lO` | (no BSD file flags) | macOS only |

Official references: `man zshbuiltins` (`cd`, `pushd`, `hash`), `man zshexpn`
(named directories), and the macOS and GNU coreutils man pages.

## Examples (13 of 13 built)

01. [Lisbon pastelaria Christmas orders](01-lisbon-pastelaria-orders/) — available
02. [Hanoi water puppet theatre pre-show round](02-hanoi-water-puppet-round/) — available
03. [Reykjavík geothermal turbine inspection](03-reykjavik-geothermal-inspection/) — available
04. [Kathmandu trekking permit desk](04-kathmandu-trekking-permits/) — available
05. [Oaxaca recording studio, picking the latest takes](05-oaxaca-studio-takes/) — available
06. [Accra outdooring photos from a cousin's phone](06-accra-outdooring-photos/) — available
07. [Montevideo school office sorting parents' attachments](07-montevideo-school-forms/) — available
08. [Kigali moto-taxi fare app release switch](08-kigali-release-switch/) — available
09. [Kraków organ workshop voicing reports](09-krakow-organ-workshop/) — available
10. [Tbilisi film archive, mirroring digitized reels](10-tbilisi-film-archive/) — available
11. [Marrakech carpet cooperative named folders](11-marrakech-carpet-cooperative/) — available
12. [Helsinki music academy practice-room cleanup](12-helsinki-practice-rooms/) — available
13. [Tokyo woodblock print studio, tidying before a client call](13-tokyo-woodblock-studio/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Bakery (business) | `mkdir -p` for a whole tree, relative `cd`, `touch`, `ls -F` |
| 02 | Theatre (art) | `pushd`/`popd` round trip, reading `$dirstack`, `cd -` |
| 03 | Power plant (mechanical) | `cdpath` jumps and zsh's `cd old new` path swap |
| 04 | Trekking agency (business) | `head`/`tail` windows on a CSV, BSD-safe `wc -l`, `cat -n` |
| 05 | Recording studio (music) | `touch -t` and `touch -r` timestamps, `ls -t`/`ls -tr` |
| 06 | Family | Tab-separated rename plan, `cp -p` backups, no-clobber `mv -n` |
| 07 | Primary school (education) | `file --mime-type` and a `case` router |
| 08 | Startup (tech) | `ln -sfn` release switch, `readlink`, the `ln -sf` stray-link trap |
| 09 | Organ builder (music, mechanical) | GNU-vs-BSD `stat`, `zstat`, `-nt` and `-s` tests |
| 10 | Film archive (art) | Portable `cp -R src/. dest/`, `diff -r`, `du -sk` ranking |
| 11 | Carpet cooperative (business) | Named directories with `hash -d`, `print -D`, `${(D)...}` |
| 12 | Music academy (education) | Safe deletion: `rm --`, `rmdir` sweep, `${var:?}` guard, `rm -f` |
| 13 | Print studio (art) | macOS `chflags hidden`, `ls -lO`, `xattr`, `cp -X` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
