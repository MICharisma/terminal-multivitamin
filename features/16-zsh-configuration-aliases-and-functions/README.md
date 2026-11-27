# zsh configuration, aliases, and functions

How a zsh session finds its personality: startup files under `ZDOTDIR`, aliases
(plain, suffix, and global), functions and `autoload`/`fpath`, options
(`setopt` / `[[ -o ]]`), prompts, completion (`compinit`), hooks, `zstyle`, and
key bindings. Every scenario builds a throwaway config tree and never touches
your real `~/.zshrc`.

| File | When it runs |
| --- | --- |
| `.zshenv` | every zsh (unless `-f`) |
| `.zprofile` | login shells |
| `.zshrc` | interactive shells |
| `.zlogin` | login shells, after `.zshrc` |

Point `ZDOTDIR` at a folder of your own to keep experiments out of `$HOME`.

Official references: `man zsh`, `man zshoptions`, `man zshbuiltins` (`alias`,
`autoload`, `zstyle`), `man zshcontrib` (`add-zsh-hook`), `man zshcompsys`.

## Examples (13 of 13 built)

01. [Bogotá agency shell aliases](01-bogota-agency-aliases/) — available
02. [Prague theory-lab suffix aliases](02-prague-theory-suffix/) — available
03. [Cape Town family global aliases](03-cape-town-global-aliases/) — available
04. [Chiang Mai lacquer workshop functions](04-chiang-mai-functions/) — available
05. [Vienna chamber orchestra autoload](05-vienna-orchestra-autoload/) — available
06. [Lyon bicycle cooperative local options](06-lyon-bike-local-options/) — available
07. [Dhaka fintech option probe](07-dhaka-fintech-options/) — available
08. [Colombo school ZDOTDIR load order](08-colombo-school-zdotdir/) — available
09. [Sarajevo radio prompt](09-sarajevo-radio-prompt/) — available
10. [Auckland ferry completions](10-auckland-ferry-compinit/) — available
11. [Campinas makerspace hooks](11-campinas-makerspace-hooks/) — available
12. [Stavanger offshore zstyle](12-stavanger-offshore-zstyle/) — available
13. [Ulaanbaatar library modular zshrc](13-ulaanbaatar-library-modular/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Ad agency (business) | `alias`, `alias -L`, `unalias` |
| 02 | Theory lab (education) | `alias -s` suffix aliases |
| 03 | Family archive (family) | `alias -g` global aliases |
| 04 | Lacquer workshop (art) | `function`, `typeset -f`, functions vs aliases |
| 05 | Chamber orchestra (music) | `autoload -Uz`, `fpath` |
| 06 | Bike cooperative (mechanical) | `emulate -L zsh`, `setopt local_options` |
| 07 | Fintech (tech) | `setopt` / `unsetopt`, `[[ -o ]]` |
| 08 | International school (education) | `ZDOTDIR` load order across startup files |
| 09 | Community radio (nonprofit) | `PROMPT` / `RPROMPT` |
| 10 | Ferry ops (mechanical) | `compinit -u`, completion `fpath` |
| 11 | Makerspace (tech) | anonymous functions, `add-zsh-hook` |
| 12 | Offshore ops (business) | `zstyle` for completion and vcs_info |
| 13 | National library (government) | modular `source`, `bindkey`, named dirs |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
