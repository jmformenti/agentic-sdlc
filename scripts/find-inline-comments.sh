#!/usr/bin/env bash
# Print the inline (diff) review comments of a pull request written by trusted
# authors, one block per comment, ready to be embedded in a prompt.
#
# Usage: find-inline-comments.sh <owner/repo> <pr-number>
set -euo pipefail

repo="${1:?usage: find-inline-comments.sh <owner/repo> <pr-number>}"
pr="${2:?pr number is required}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

gh api "repos/$repo/pulls/$pr/comments" --paginate \
  | jq -s -r -L "$here" 'include "trusted-comments";
      add | .[] | trusted
      | "- `\(.path)` line \(.line // .original_line // "?"):\n  \(.body | gsub("\n"; "\n  "))"'
