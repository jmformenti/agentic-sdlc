Review pull request #{{pr}} of the repository `{{repository}}` (read it with `gh pr view {{pr}}`
and `gh pr diff {{pr}}`). Do not launch subagents: do the whole review yourself in this turn.
This is automatic review cycle number {{cycle}} for this PR.

Write every comment in this language: **{{language}}**.

## Plan conformance

{{plan_section}}

## Scope

{{ci_section}}

You have no tools to write temporary files either: do not try.

Review the whole diff looking at:

- Correctness: bugs, edge cases, regressions.
- Compliance with the repository's documented conventions (CLAUDE.md, CONTRIBUTING, README):
  architecture layers, naming, language of user-facing strings, etc.
- Tests: new logic without coverage must be reported (by reading, not by running anything).
- Security: authorization checks, secrets handling, input validation.

## Output

1. One inline comment (`mcp__github_inline_comment__create_inline_comment`) per concrete
   problem, stating its severity.
2. One single summary comment on the PR (`gh pr comment {{pr}}`) whose **first line is exactly**
   `<!-- claude-sdlc:review cycle={{cycle}} verdict=VERDICT -->` where VERDICT is `pass`,
   `warning` or `fail`, followed by a heading and the report: overall verdict, conformance with
   the issue plan (if any) and the list of problems found (or a statement that everything is
   correct).
3. Finish by returning the structured result `{"verdict": "...", "summary": "..."}` with the
   same verdict as the marker.

Verdict scale:
- `pass`: mergeable as is (or only trivial nits that do not need another cycle).
- `warning`: must be fixed before merge but nothing is fundamentally wrong.
- `fail`: bugs, missing plan items, security issues or broken conventions.

Do not change any code and do not add or remove labels: a deterministic step after you labels
the PR from your verdict.
