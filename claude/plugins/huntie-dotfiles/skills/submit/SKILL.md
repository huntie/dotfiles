---
name: submit
description: Submit work for review as GitHub PRs (gh) or Graphite stacks (gt). Use when asked to create or update a PR, put code up for review, or after amending already-submitted commits.
---

# Submitting Code

Create and maintain pull requests for the current work. Commit messages are the source of truth for PR titles and bodies — this skill moves them into review and keeps them in sync. Message content itself is always generated with the `/commit-msg` skill, never drafted here.

## Backend detection

First match wins. Check for git first — Sapling's git interop makes `sl root` succeed inside git repos, so it is not a discriminator on its own.

1. `git rev-parse --git-dir` fails → not a git repo. If `sl root` succeeds it is a Sapling repo: this skill does not apply — defer to Meta tooling.
2. `[ -f "$(git rev-parse --git-dir)/.graphite_repo_config" ]` → Graphite (`gt`).
3. `gh repo view` succeeds → plain GitHub (`gh`).
4. Otherwise → no submission backend. Commit locally via `/commit-msg` and say there is nothing to submit.

## Every run

1. **Inventory**: list the local commits and branches ahead of the base, and their open PRs (`gh pr status`, or `gt log short` for stacks).
2. **Re-scan messages**: for each commit being submitted, check the message still matches its diff. If the diff changed since the message was written, regenerate via `/commit-msg` and amend.
3. **Read remote state before overwriting**: `gh pr view --json title,body`. Fold meaningful human edits back into the commit message first — then the updated commit message wins.
4. **Push code**, then **sync metadata** so each PR's title and body match its commit message.

Rules:

- Never create a PR sight-unseen — first submission always goes through the draft buffer below.
- Create PRs as **drafts** (a readiness signal only — GitHub drafts are still visible to anyone who can see the repo, which is why the buffer step exists). Never run `gh pr ready` unless explicitly asked — publishing is the user's action.
- Force-push only with `--force-with-lease`.

## First submission: draft buffer

GitHub and Graphite have no private drafts, so stage PR metadata locally before anything is created:

1. Write the proposed title and body to `$(git rev-parse --git-dir)/pr-drafts/<branch>.md` — title on the first line, a blank line, then the body.
2. Point the user at the file and stop. Wait for them to edit and confirm.
3. On confirmation, re-read the buffer, fold any user edits back into the commit message (it stays the source of truth), then create the PR from the buffer content and delete the file.

Once a PR exists, skip the buffer — subsequent runs edit the live PR directly per the re-scan rule.

## GitHub (gh)

Default shape: one branch per PR, one commit per PR. PR title = commit title; PR body = commit summary.

- Create (after buffer confirmation): `git push -u origin <branch>`, then `gh pr create --draft --title "<Title>" --body "<Body>"`.
- Update: `git push --force-with-lease`, then `gh pr edit --title "<Title>" --body "<Body>"` per the re-scan rule.
- If the repo has a PR template (`.github/PULL_REQUEST_TEMPLATE.md`), map the summary into its sections (e.g. Summary / Changelog / Test Plan) instead of pasting free-form.
- Include a Test Plan whenever the template asks for one, derived from how the change was verified in-session.
- Multi-commit PRs (the branch is genuinely one reviewable unit of several commits): the PR body is a branch-level summary over the full branch diff, following `/commit-msg` format rules; per-commit messages stay per-commit.

## Graphite (gt)

Stacked PRs: one commit per branch, one branch per PR. Always pass `--no-interactive` — never let `gt` open editors or prompts.

- New unit of work: `gt create -am "<Title>"`. Amend the current unit: `gt modify -a` (auto-restacks upstack branches). Collapse accidental multi-commit branches: `gt squash`.
- Submit or update code: `gt submit --stack --draft --no-edit --no-ai --no-interactive`.
- First submit of a stack creates PRs for **every** branch at once: write one draft buffer per branch and get all of them confirmed beforehand, then apply each with `gh pr edit` immediately after the submit.
- Metadata: plain `gt submit` never touches an existing PR's title or body, so sync each PR with `gh pr edit` (safe on gt-managed branches) per the re-scan rule.
- Stack summary: each PR body stands alone for its own change. Put stack-wide motivation under a `**Context**` subheading in the bottom PR's body, and reference it from upstack PRs ("Part of the stack starting at #N"). Graphite's bot comment handles stack navigation.
- After any PR in the stack merges (including via `gh pr merge` or the web UI): run `gt sync`, then resubmit the stack — merging outside the Graphite app skips auto-restack.
- Restack conflicts: resolve, then `gt continue`; back out with `gt abort`.
