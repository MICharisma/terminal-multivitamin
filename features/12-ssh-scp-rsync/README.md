# ssh, scp, and rsync

Copying files and hopping between hosts without leaving the terminal: OpenSSH's
`ssh`, `scp`, `ssh-keygen`, and `ssh-agent`, plus `rsync` for mirrored trees.
Every scenario stays offline — a throwaway local `sshd`, `ssh -G` config
resolution, or plain directory-to-directory `rsync`.

OpenSSH and rsync agree on most flags across macOS and Linux. A few tips the
slots lean on:

| Task | Tip |
| --- | --- |
| Resolve a Host block without connecting | `ssh -G -F config alias` |
| Keep host keys out of `~/.ssh` | `UserKnownHostsFile` pointed at the workdir |
| First connect without a prompt | `StrictHostKeyChecking accept-new` (or `no` in a sandbox) |
| Mirror then prune stale files | `rsync --delete -av` |
| Preview a sync | `rsync --dry-run -av` |
| macOS Keychain + agent | `UseKeychain yes` with `AddKeysToAgent yes` |

Official references: `man ssh_config`, `man scp`, `man ssh-keygen`, `man ssh-agent`,
and `man rsync`.

## Examples (13 of 13 built)

01. [Tallinn sprint staging hosts](01-tallinn-sprint-hosts/) — available
02. [Addis Ababa Institute of Technology lab keys](02-addis-ababa-lab-keys/) — available
03. [Porto family photos to grandmother's inbox](03-porto-family-photos/) — available
04. [Chiang Mai Night Bazaar gallery crates](04-chiang-mai-gallery-crates/) — available
05. [Cape Town Baxter Theatre rehearsal sync](05-cape-town-rehearsal-sync/) — available
06. [Lyon CNC shop dry-run](06-lyon-cnc-dry-run/) — available
07. [Bogotá Contadoría invoice exclude](07-bogota-invoice-exclude/) — available
08. [Edinburgh fintech desk agent keys](08-edinburgh-agent-keys/) — available
09. [Dhaka payments jumpbox mux](09-dhaka-mux-jumpbox/) — available
10. [Riga open-data bastion hop](10-riga-bastion-hop/) — available
11. [Amman campus dashboard tunnel](11-amman-campus-tunnel/) — available
12. [Osaka score library mirror](12-osaka-score-mirror/) — available
13. [Kyoto mokuhanga supplier Keychain hosts](13-kyoto-keychain-hosts/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Mobility startup (tech) | `Host` / `HostName` / `User` / `IdentityFile`, resolved with `ssh -G` |
| 02 | Engineering school (education) | `ssh-keygen -t ed25519` with `-f`, `-N`, and `-C` |
| 03 | Family | One-file `scp` through a local `sshd`, with `StrictHostKeyChecking` |
| 04 | Gallery (art) | `scp -r` shipping whole crate folders |
| 05 | Theatre (music) | Local `rsync -av` of rehearsal takes into an archive week |
| 06 | CNC shop (mechanical) | `rsync --dry-run` over a plan file of programmes |
| 07 | Accounting desk (business) | `rsync --exclude` via a `case` router |
| 08 | Fintech desk (tech) | `ssh-agent`, `ssh-add`, and `ssh-add -l` in a subshell |
| 09 | Payments lab (tech) | `ControlMaster` / `ControlPath` / `ControlPersist` mux config |
| 10 | Open data (government) | `ProxyJump` through a bastion Host block |
| 11 | University (education) | `LocalForward` for a campus dashboard |
| 12 | Orchestra library (music) | `rsync --delete` pruning a stale score mirror |
| 13 | Print studio (art) | macOS `UseKeychain` and `AddKeysToAgent` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
