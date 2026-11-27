# Pipes and redirection

Where a command's input comes from and where its output goes. Every command starts
with three open streams: stdin (0), stdout (1), and stderr (2). Redirections point
them at files (`<`, `>`, `>>`, `2>`), at each other (`2>&1`), or at nothing
(`/dev/null`); pipes (`|`) connect one command's stdout to the next one's stdin.
This feature covers those, plus here-docs and here-strings, `tee`, process
substitution (`<(...)`, zsh's `=(...)`), extra descriptors with `exec`, named pipes,
pipeline exit statuses, and zsh's `multios`. One slot is written in bash and one
in POSIX `sh`, to show where the shells differ.

Redirections are applied left to right, and that explains most surprises:

| You write | stdout goes to | stderr goes to |
| --- | --- | --- |
| `cmd > log 2>&1` | `log` | `log` |
| `cmd 2>&1 > log` | `log` | where stdout pointed before (the terminal or the pipe) |
| `cmd 2>/dev/null` | the terminal | nowhere |
| `cmd 2>&1 >/dev/null \| wc -l` | nowhere (bash), also the pipe (zsh `multios`) | the pipe |

zsh vs bash vs POSIX `sh` at a glance:

| Idea | zsh | bash | POSIX `sh` |
| --- | --- | --- | --- |
| Both streams down a pipe | `\|&` | `\|&` (bash 4+, not macOS's 3.2) | `2>&1 \|` |
| Both streams to a file | `&> file` | `&> file` | `> file 2>&1` (dash reads `&>` as `&` then `>`) |
| Per-stage exit statuses | `$pipestatus` | `$PIPESTATUS` | none (use `set -o pipefail` where supported) |
| One output to several files | `> a > b` (`multios`) | `\| tee a b` | `\| tee a b` |
| Here-string | `<<< "$text"` | `<<< "$text"` | here-doc or `printf '%s\n' "$text" \|` |
| Process substitution | `<(...)`, `=(...)` | `<(...)` | none |
| Last pipeline stage runs in the current shell | yes, so `\| read v` works | no (unless `shopt -s lastpipe`) | depends on the shell |

Official references: `man zshmisc` ("Redirection", "Multios"), `man zshexpn`
("Process Substitution"), `man bash` ("REDIRECTION", "Pipelines"), and the macOS
man pages for `tee`, `mkfifo`, `pbcopy`, and `pbpaste`.

## Examples (13 of 13 built)

01. [Mumbai dabbawala lunch manifest](01-mumbai-dabbawala-manifest/) — available
02. [Buenos Aires milonga DJ, building tandas](02-buenos-aires-milonga-tandas/) — available
03. [Istanbul ferry engine room, comparing both engines](03-istanbul-ferry-engine-room/) — available
04. [Cork secondary school, Skellig Michael trip letters](04-cork-school-trip-letters/) — available
05. [Lagos family splitting a hospital bill](05-lagos-hospital-bill-split/) — available
06. [Bengaluru delivery app, keeping the release build log](06-bengaluru-app-release-build/) — available
07. [Vienna opera costume store, checking the crates after a tour](07-vienna-opera-costume-store/) — available
08. [São Paulo samba school, one rehearsal notice for every wing](08-sao-paulo-samba-rehearsal/) — available
09. [Hamburg container terminal crane telemetry, in bash](09-hamburg-crane-telemetry/) — available
10. [Cape Town solar installer's nightly report, in portable sh](10-cape-town-solar-nightly-report/) — available
11. [Bogotá university library, renewing loans in a batch](11-bogota-library-renewals/) — available
12. [Copenhagen furniture workshop, pasting a cut list](12-copenhagen-furniture-cut-list/) — available, macOS only
13. [Mexico City seismic alert relay](13-mexico-city-seismic-relay/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Lunch delivery (business) | `>` vs `>>`, a counting pipeline, `noclobber` and `>\|`, the `sort f > f` trap |
| 02 | Milonga DJ (music) | stdout vs stderr, `2>`, `2>/dev/null`, `2>&1` order, zsh `multios` in pipes, `\|&` |
| 03 | Ferry engine room (mechanical) | `<`, a loop fed with `done < file`, `exec 3<` descriptors read in step |
| 04 | Secondary school (education) | Here-docs: expanding, quoted, tab-stripped, feeding a loop |
| 05 | Family | Here-strings into `tr`, `wc`, `grep`, `read`, and `read -A` |
| 06 | Startup (tech) | `tee` to keep a log, tap pipeline stages, append, and fan out |
| 07 | Opera house (art) | Process substitution with `diff`, `comm`, `paste`; `<(...)` vs `=(...)` |
| 08 | Samba school (music) | zsh `multios`: several outputs, file plus pipe, several inputs, `no_multios` |
| 09 | Container terminal (mechanical) | bash: hidden pipeline failures, `PIPESTATUS`, `pipefail`, no `\|&` in bash 3.2 |
| 10 | Solar installer (business) | POSIX `sh`: `exec` for the whole script, saved descriptors, group redirection |
| 11 | University library (education) | A loop's stdin swallowed by a command; `< /dev/null`, `read -u 3`, `: > file` |
| 12 | Furniture workshop (art) | macOS `pbcopy`/`pbpaste` in pipelines, clipboard saved and restored |
| 13 | Seismic network (tech, science) | Capstone: `mkfifo`, `wait`, `exec {fd}`, capturing only stderr, `tee` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
