#!/usr/bin/env bash
# Print the issue number a pull request implements, or nothing.
# Looks for "Closes/Fixes/Resolves #N" in the PR body, then for the branch name
# "<branch-prefix>N".
#
# Usage: find-linked-issue.sh <owner/repo> <pr-number> <branch-prefix>
set -euo pipefail

repo="${1:?usage: find-linked-issue.sh <owner/repo> <pr-number> <branch-prefix>}"
pr="${2:?pr number is required}"
prefix="${3:?branch prefix is required}"

json=$(gh pr view "$pr" --repo "$repo" --json body,headRefName)
body=$(jq -r '.body // ""' <<< "$json")
branch=$(jq -r '.headRefName // ""' <<< "$json")

issue=$(grep -oiE '(close|closes|closed|fix|fixes|fixed|resolve|resolves|resolved) #[0-9]+' <<< "$body" \
  | head -1 | grep -oE '[0-9]+' || true)

if [ -z "$issue" ] && [[ "$branch" == "$prefix"* ]]; then
  issue=$(grep -oE '^[0-9]+' <<< "${branch#"$prefix"}" || true)
fi

printf '%s' "$issue"
