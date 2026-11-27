# Permissions and ownership · 01 · Bengaluru hosting support desk, decoding a pasted `ls -l`

A customer of a Bengaluru web-hosting company opens ticket 48213: "our shop's config keeps changing by itself". They paste `ls -l` from their server, and the support engineer reads the mode column character by character: the type, three `rwx` triads turned into octal, the setuid and sticky letters, the `+` that means an ACL, and the two world-writable entries that explain the ticket. The listing is a fixture, so the script only parses text.

**What it teaches**

- the first character of an `ls -l` mode is the type: `-` file, `d` folder, `l` symlink, `c` character device
- the next nine are three triads (owner, group, others); `r`=4, `w`=2, `x`=1 add up to one octal digit each
- `s` in the owner triad means setuid plus execute, `S` setuid without execute, and `t` in the others triad is the sticky bit
- a trailing `+` means an ACL is attached (macOS also shows `@` for extended attributes)
- world-writable files, and world-writable folders without the sticky bit, are the lines to raise with the customer

**Lesson steps**

1. Split each pasted line into mode, name, and link target (`ls -l`)
2. Read the type from the first character (`ls -l`)
3. Turn each rwx triad into an octal digit (`rwx = 4 2 1`)
4. Spot setuid, setgid, sticky, and ACL markers (`setuid setgid sticky`)
5. Flag world-writable files and folders for the customer (`o+w`)

**Files**

| File | Role |
| --- | --- |
| [`decode_listing.zsh`](decode_listing.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/ticket-48213_ls-l.txt`](fixtures/ticket-48213_ls-l.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/01-bengaluru-support-ticket/decode_listing.zsh
tests/run-examples.zsh 01-bengaluru-support-ticket
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
