#!/usr/bin/env bash
# claude-sdlc e2e hook: stop the application. Always runs, even after failures.
set -euo pipefail
docker compose down -v
