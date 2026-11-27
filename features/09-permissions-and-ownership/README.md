# Permissions and ownership

Who can read, write, and run a file: `ls -l` modes, octal and symbolic `chmod`,
`umask`, the execute bit and exit statuses 126/127, what `r`/`w`/`x` mean on a
folder, read-only files that still get replaced, mode-bit arithmetic for secrets,
`find -perm` audits, `chown`/`chgrp` without root and a reviewed `sudo` plan,
`install -m`, restoring execute bits after a Windows zip, and macOS ACLs.

macOS and Linux agree on the Unix permission bits, and disagree on the extras:

| Task | macOS (BSD) | Linux (GNU) | Portable |
| --- | --- | --- | --- |
| Read a mode as octal | `stat -f %Lp` | `stat -c %a` | zsh `zstat -o +mode` |
| List ACLs | `ls -le`, `chmod +a` / `-a` / `-N` | `getfacl` / `setfacl` | macOS-only slot |
| "Any of these bits" in find | old: `-perm +022`; new: `-perm /022` | `-perm /022` | `\( -perm -0020 -o -perm -0002 \)` |
| Install with an exact mode | `install -m` (same) | `install -m` (same) | `install -m` / `install -d -m` |

Official references: `man chmod`, `man umask`, `man install`, `man find`
(`-perm`), `man zshmodules` (`zsh/stat`), and on macOS `man chmod` for the `+a`
ACL clauses.

## Examples (13 of 13 built)

01. [Bengaluru hosting support desk, decoding a pasted `ls -l`](01-bengaluru-support-ticket/) — available
02. [Addis Ababa coffee roastery, setting modes on the web shop](02-addis-ababa-roastery-site/) — available
03. [Vienna music university, sharing chamber music scores](03-vienna-chamber-music-scores/) — available
04. [Istanbul ferry engine room, the check script that will not run](04-istanbul-ferry-engine-room/) — available
05. [Hobart Antarctic research lab, choosing a umask for ice core data](05-hobart-ice-core-lab/) — available
06. [Quito university, an exam drop folder students cannot browse](06-quito-exam-drop-folder/) — available
07. [Dakar family recipe book, a read-only file that still gets replaced](07-dakar-family-recipes/) — available
08. [Tallinn payments startup, refusing keys that are too open](08-tallinn-payment-keys/) — available
09. [Port of Rotterdam planning office, auditing a shared drive](09-rotterdam-port-shared-drive/) — available
10. [Cape Town sea rescue station, handing files to the station account](10-cape-town-rescue-handover/) — available
11. [Gdańsk shipyard welding cell, installing robot tools in portable sh](11-gdansk-welding-robot-tools/) — available
12. [Taipei game studio, restoring execute bits after a Windows zip, in bash](12-taipei-game-build-tools/) — available
13. [Barcelona architecture studio, guarding competition renders with ACLs](13-barcelona-competition-renders/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Hosting support (tech) | Decode a pasted `ls -l`: type, `rwx`→octal, setuid/`S`/`t`, `+`, world-writable |
| 02 | Coffee roastery (business) | Octal plan in an associative array, `zstat -o +mode`, recover from `chmod -R 777` |
| 03 | Music university (music, education) | Symbolic modes: `g+rX` vs `g+rx`, `o-rwx`, `g=u`, comma clauses, `a-w` |
| 04 | Ferry engine room (mechanical) | Exit 126 vs 127, `chmod u+x`, bad `#!` with `\r`, folder needs `x` too |
| 05 | Antarctic research lab (science) | `umask` table, `umask -S`, octal prediction, scoped in a subshell, `mkdir -m` |
| 06 | University exam desk (education) | Folder `r`/`w`/`x` matrix, `-wx` drop box (mode 300) |
| 07 | Family recipe book (family) | Read-only file still replaceable via `mv`/`rm`; lock the folder; `{ } always { }` |
| 08 | Payments startup (tech) | Mode-bit arithmetic `(( mode & 8#077 ))`, OpenSSH-style refusal, `chmod go=` |
| 09 | Port planning office (government) | `find -perm` audits, portable "any of bits", `-exec chmod {} +` |
| 10 | Sea rescue station (nonprofit) | `ls -n`, allowed `chown`/`chgrp`, refused changes, quoted `sudo` plan (never run) |
| 11 | Shipyard welding cell (mechanical) | POSIX `sh`: `install -m` / `install -d -m`, here-doc manifest vs `cp` |
| 12 | Game studio (art, tech) | bash: restore `x` after a Windows zip via `#!`, `find -print0`, `chmod +x` vs umask |
| 13 | Architecture studio (art) | macOS ACLs: `chmod +a` deny delete, inheritance, `ls -le`, `chmod -a` / `-N` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
