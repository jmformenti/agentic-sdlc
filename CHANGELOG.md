# Changelog

## v1.0.0 — 2026-09-05

First release, extracted from the `habitus-trainer` autonomous flow. Briefly published the
same day under the name `claude-sdlc`; renamed to `agentic-sdlc` (repository, markers,
`.github/agentic-sdlc/` directory, `AGENTIC_SDLC_*` variables, caller file names, default
branch prefix `agent/issue-`) to respect Anthropic's trademark guidelines, and the release
re-tagged. Nothing consumed the earlier name except habitus-trainer, migrated in the same day. Compared to the
original copied workflows:

- Reusable workflows (`workflow_call`) with inputs; prompts and helpers fetched from this
  repository at the exact executing commit.
- Prompts in English, `language` input for the text Claude writes.
- Machine-readable markers (`<!-- agentic-sdlc:plan -->`, `<!-- agentic-sdlc:review ... -->`,
  `<!-- agentic-sdlc:e2e ... -->`) instead of language-bound headings.
- Verdict from structured output + deterministic labelling (one Claude run per review
  instead of two).
- Trust filter on plans, review reports and inline comments (author association / bot).
- Conservative defaults: `max-review-cycles: 3`, `max-turns` 100–200.
- Draft PRs are not reviewed until marked ready.
- E2E stage generalised through `e2e-up.sh` / `e2e-down.sh` hooks.
- `bootstrap.sh` installer, `self-check.yml` lint.
