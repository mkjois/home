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

## External resources are read-only by default

- Never mutate an external resource without my explicit permission. Inspection and other
  read-only operations are allowed.
- Mutations include HTTP `POST`, `PUT`, `PATCH`, and `DELETE` requests; SQL `INSERT`, `UPDATE`,
  `DELETE`, `MERGE`, `GRANT`, `REVOKE`, and DDL statements; and infrastructure or configuration
  commands such as Terraform `apply`, Salt state application, Ansible playbook execution, Packer
  builds, Kubernetes `apply`, Helm upgrades, deployments, restarts, and equivalent operations.
- Do not infer permission to mutate from a request to investigate, diagnose, review, or plan.

## Optional work instructions

- Before starting work, check whether `~/.config/ai/AGENTS.work.md` exists.
- If it exists, read it completely and follow it in addition to this file.
- Treat the work instructions as more specific if they conflict with this file.
- If it does not exist, continue silently.

## Default shell

- My default interactive shell is the latest Bash, not the macOS default Zsh.
- Prefer Bash-compatible commands and examples for portability to remote hosts, which usually
  default to Bash.
