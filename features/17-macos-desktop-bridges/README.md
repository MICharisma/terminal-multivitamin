# macOS desktop bridges

Commands that connect the Terminal to the rest of macOS: opening files and apps
(`open`), the pasteboard (`pbcopy` / `pbpaste`), speech (`say`), screenshots
(`screencapture`), AppleScript (`osascript`), image edits (`sips`), and document
conversion (`textutil`).

These tools are macOS-only. Every script starts with `# requires: macos`, checks
`$OSTYPE`, and exits 2 elsewhere; the Linux CI job skips them, and the macOS job
runs them with `--macos-only`.

Anything that would pop a GUI, ask for screen-recording or automation permission,
or play audio is guarded: when `TERM` is `dumb` or stdout is not a tty (as in the
test runner), the script prints what it would run instead of calling the tool.
Clipboard, `sips`, `textutil`, and non-GUI `osascript` run for real inside the
sandbox.

Official references: `man open`, `man pbcopy`, `man say`, `man screencapture`,
`man osascript`, `man sips`, `man textutil`.

## Examples (13 of 13 built)

01. [Quito family photo album, revealing a roll in Finder](01-quito-family-album/) — available, macOS only
02. [Colombo tea auction clipboard for the lot board](02-colombo-tea-lot-clipboard/) — available, macOS only
03. [Antwerp diamond atelier contact sheets](03-antwerp-diamond-contact-sheets/) — available, macOS only
04. [Belfast radio rundown, converting the cue sheet](04-belfast-radio-rundown/) — available, macOS only
05. [Kampala school bulletin via AppleScript](05-kampala-school-bulletin/) — available, macOS only
06. [Almaty climbing club route cards](06-almaty-route-cards/) — available, macOS only
07. [Recife bloco rehearsal callouts](07-recife-bloco-callouts/) — available, macOS only
08. [Valletta maritime museum wall-label captures](08-valletta-wall-labels/) — available, macOS only
09. [Sapporo miso brewery label formats](09-sapporo-miso-labels/) — available, macOS only
10. [La Paz family recipe cards to HTML](10-lapaz-recipe-cards/) — available, macOS only
11. [Cluj-Napoca deploy notes on the pasteboard](11-cluj-deploy-notes/) — available, macOS only
12. [Fez calligraphy studio, revealing a folio](12-fez-calligraphy-reveal/) — available, macOS only
13. [Tromsø aurora desk, bridging a night's report](13-tromso-aurora-desk/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Family | `open` a folder and a photo; headless guard prints what would run |
| 02 | Tea auction (business) | `pbcopy` / `pbpaste` pipeline for a lot line |
| 03 | Diamond atelier (art) | `sips -Z` and `sips -g` over a glob of stones |
| 04 | Radio station (music) | `textutil -convert` driven by a while-read plan |
| 05 | Primary school (education) | `osascript -e` wrapped in a function with `emulate -L zsh` |
| 06 | Climbing club (nonprofit) | `case` router choosing `open -a` / `open file://` |
| 07 | Carnival bloco (music) | `say -v` over `${(kv)array}` of callouts |
| 08 | Maritime museum (government) | `screencapture` flags from a plan; always dry under the guard |
| 09 | Miso brewery (business) | `sips -s format` before/after on a label PNG |
| 10 | Family | `textutil -stdin` fed from a here-document |
| 11 | Tech co-op | pasteboard filled via process substitution |
| 12 | Calligraphy studio (art) | `open -R` plus `osascript --` with argv |
| 13 | Aurora desk (science) | capstone dispatch across open, pbcopy, textutil |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
