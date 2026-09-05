#!/usr/bin/env bash
# Replace the verdict label of a pull request. The three verdict labels are
# mutually exclusive.
#
# The removal and the addition are deliberately two separate `gh pr edit`
# calls: GitHub only emits a new `labeled` event (which is what triggers the
# fix-review and e2e workflows) when the label is really removed and added
# again, which does not happen with a single combined call when the verdict is
# the same as the previous one.
#
# GH_TOKEN must be an *app or user* token, never the workflow's GITHUB_TOKEN:
# events created with GITHUB_TOKEN never trigger other workflows.
#
# Usage: set-verdict-label.sh <pr-number> <pass|warning|fail> <label-pass> <label-warning> <label-fail> [<label-to-remove-on-pass>]
set -euo pipefail

pr="${1:?pr number}"
verdict="${2:?verdict}"
label_pass="${3:?label pass}"
label_warning="${4:?label warning}"
label_fail="${5:?label fail}"
remove_on_pass="${6:-}"

case "$verdict" in
  pass)    add="$label_pass" ;;
  warning) add="$label_warning" ;;
  fail)    add="$label_fail" ;;
  *) echo "set-verdict-label: unknown verdict '$verdict'" >&2; exit 1 ;;
esac

gh pr edit "$pr" --remove-label "$label_pass" --remove-label "$label_warning" --remove-label "$label_fail"
if [ "$verdict" = "pass" ] && [ -n "$remove_on_pass" ]; then
  gh pr edit "$pr" --add-label "$add" --remove-label "$remove_on_pass"
else
  gh pr edit "$pr" --add-label "$add"
fi
echo "PR #$pr labelled '$add'"
