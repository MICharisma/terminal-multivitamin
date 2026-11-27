# Permissions and ownership · 13 · Barcelona architecture studio, guarding competition renders with ACLs

An architecture studio in Barcelona is entering the competition for the park over the Sagrera rail station. Two days before the deadline, nobody should be able to delete a final render by accident, not even the partner who made it. macOS access control lists do that: an "everyone deny delete" entry beats the Unix bits, and a folder entry with inheritance flags passes it on to every render saved later. `chmod +a` and `ls -le` are macOS features, so this is the one example in this feature that the Linux test job skips.

**What it teaches**

- `chmod +a "everyone deny delete"` adds an access control entry (ACE) that stops even the owner
- `ls -le` lists the ACEs under the file; plain `ls -l` only shows a `+` after the mode
- `file_inherit,directory_inherit` on a folder copies an ACE onto every new file, marked `inherited`
- `chmod -a` removes one entry, `chmod -N` removes them all
- deny-delete entries also stop `rm -rf`, so the cleanup trap runs `chmod -R -N` first

**Lesson steps**

1. Add a deny-delete entry to the final render (`chmod +a`)
2. List the entries with ls -le (`ls -le`)
3. Watch the owner's rm get refused (`chmod +a`)
4. Make new renders inherit the entry from their folder (`file_inherit,directory_inherit`)
5. Remove one entry and delete the old version (`chmod -a`)
6. Remove every entry under the competition folder (`chmod -N`)

**Files**

| File | Role |
| --- | --- |
| [`acl_renders.zsh`](acl_renders.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/13-barcelona-competition-renders/acl_renders.zsh
tests/run-examples.zsh 13-barcelona-competition-renders
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit (clearing its ACLs first). It needs macOS (`chmod +a`, `ls -e`); on Linux it prints a message and exits 2, and the test runner skips it.
