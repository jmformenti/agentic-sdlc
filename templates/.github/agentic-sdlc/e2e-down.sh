#!/usr/bin/env bash
# agentic-sdlc e2e hook: stop the application. Always runs, even after failures.
set -euo pipefail
docker compose down -v
