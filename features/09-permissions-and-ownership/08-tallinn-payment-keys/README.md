# Permissions and ownership · 08 · Tallinn payments startup, refusing keys that are too open

A payments startup in Tallinn signs its morning payout batches with one private key per bank. Like `ssh` with an `id_ed25519` file, the payout script refuses any key that group or others can read, and any keys folder that others can write. The modes are checked as numbers with zsh's `8#077` octal notation and `&`, the refusal message copies the one OpenSSH prints, and `chmod go=` is the one-clause fix.

**What it teaches**

- a mode is a number: `(( mode & 8#077 ))` is non-zero when group or others have any bit
- `8#077` is zsh's base notation; `printf %04o` prints the result the way ssh does
- `[[ -O file ]]` checks that you own it; `(( dir_mode & 8#022 ))` catches a folder others can write
- `chmod go=` clears every group and others bit in one clause, whatever they were
- a guard function that returns non-zero reads naturally in `if ! key_is_private ...`

**Lesson steps**

1. Test the mode bits with arithmetic, the way ssh does (`(( mode & 8#077 ))`)
2. Check that nobody else can write the keys folder (`(( mode & 8#022 ))`)
3. Refuse to sign with any key that is too open (`[[ -O ]]`)
4. Clear group and others bits on every key (`chmod go=`)

**Files**

| File | Role |
| --- | --- |
| [`key_guard.zsh`](key_guard.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/08-tallinn-payment-keys/key_guard.zsh
tests/run-examples.zsh 08-tallinn-payment-keys
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
