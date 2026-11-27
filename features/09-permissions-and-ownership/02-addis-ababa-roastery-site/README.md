# Permissions and ownership · 02 · Addis Ababa coffee roastery, setting modes on the web shop

A small roastery off Piazza in Addis Ababa runs its own web shop: static pages, one CGI script that reports beans in stock, a config folder with the Telebirr merchant key, and an uploads folder for order PDFs. Its modes live in a plan, an associative array from path to octal mode. When the uploads form fails, someone runs `chmod -R 777 shop`; the drift check shows exactly what that opened up, including the payment key, and re-applying the plan puts it back.

**What it teaches**

- octal modes name all nine bits at once: `chmod 640` is `rw-r-----`, whatever was there before
- common web modes: 644 for pages, 755 for scripts and folders, 640 for config, 600 for secrets
- `zstat -o +mode` (zsh) reads the mode back as octal on macOS and Linux alike
- keeping the plan in an associative array turns "what should it be" into a drift check, and `${+plan[$target]}` finds files nobody planned for
- `chmod -R 777` "fixes" an upload error by opening everything; re-applying the plan undoes it

**Lesson steps**

1. Write down the mode every path should have (`chmod octal plan`)
2. Apply the plan with octal chmod (`chmod octal`)
3. Read the modes back as octal and compare (`zstat -o +mode`)
4. See what chmod -R 777 does to the shop (`chmod -R 777`)
5. Re-apply the plan and keep the drop-box upload folder (`chmod octal`)

**Files**

| File | Role |
| --- | --- |
| [`apply_modes.zsh`](apply_modes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/02-addis-ababa-roastery-site/apply_modes.zsh
tests/run-examples.zsh 02-addis-ababa-roastery-site
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
