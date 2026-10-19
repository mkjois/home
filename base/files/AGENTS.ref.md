# Personal working rules

## These instructions are shared by Claude Code and Codex

- The canonical path is `~/.config/ai/AGENTS.md`. It may be a symlink; when changing these personal
  instructions, edit the file that the path resolves to rather than replacing the symlink.
- Codex loads it through the `~/.codex/AGENTS.md` symlink.
- Claude Code loads it through the import in `~/.claude/CLAUDE.md`.
- Keep the rules in the canonical file. Do not duplicate them in the product-specific loader files.

## Leave Git changes unstaged

- Make repository changes in the working tree and leave them unstaged so I can review them with
  `git diff`.
- Do not run `git add`, `git commit`, `git tag`, or other commands that modify the Git index,
  history, or refs unless I explicitly request that exact operation.
- That includes `git fetch` (with or without `--tags`), `git pull`, `git checkout -b`, `git switch`
  and `git branch <name>`: fetching updates remote-tracking refs and tags, and switching changes
  what `HEAD` points at. Work on the current branch. For a read-only look at the remote, use
  `git ls-remote` or `gh api`, which change no local refs.

## External resources are read-only by default

- Never mutate an external resource without my explicit permission. Inspection and other
  read-only operations are allowed.
- Mutations include HTTP `POST`, `PUT`, `PATCH`, and `DELETE` requests; SQL `INSERT`, `UPDATE`,
  `DELETE`, `MERGE`, `GRANT`, `REVOKE`, and DDL statements; AWS API or CLI actions other than
  read-only operations such as `Get`, `List`, and `Describe`; and infrastructure or configuration
  commands such as Terraform `apply`, Salt state application, Ansible playbook execution, Packer
  builds, Kubernetes `apply`, Helm upgrades, deployments, restarts, and equivalent operations.
- Do not infer permission to mutate from a request to investigate, diagnose, review, or plan.

## Optional work instructions

- Before starting work, check whether `~/.config/ai/AGENTS.work.md` exists.
- If it exists, read it completely and follow it in addition to this file.
- Treat the work instructions as more specific if they conflict with this file.
- If it does not exist, continue silently.

## Never run `go install`

- Several agent sessions may work on separate copies of the same repo at once, and `go install`
  writes every copy's binary to the same shared `$GOBIN` path, so the last build silently wins.
- To build a binary, use `go build -o <path> <package>` and run it from that path. Put it in the
  directory you already use for temporary outputs, such as the session's scratchpad directory. If
  you have none, use a directory from `mktemp -d`, not a fixed path like `/tmp/foo` that another
  session could also write to. Build it elsewhere only when I ask for it there.
- `go build ./...` (which only checks that everything compiles), `go run`, and `go test` are fine as
  they are. Don't run `go build` without `-o` on a single main package, since that writes the
  binary into the current directory, inside the repo.
- This also applies to `go install <tool>@<version>`. If a tool is missing, tell me rather than
  installing it.

## Default shell

- My default interactive shell is the latest Bash, not the macOS default Zsh.
- Prefer Bash-compatible commands and examples for portability to remote hosts, which usually
  default to Bash.

## Keep lines readable

- When writing Markdown, plain text, notes, skill files, or agent files, aim to keep lines to a
  width that is easy to read without wrapping, around 120 characters. Do not force this where it
  would make the content awkward, such as with long links or tables.
- Apply the same principle to code, while following the repository or language style guidelines
  for line length when they exist.
