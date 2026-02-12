#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL_NAME:-gpt-oss:20b}"
PORT="${PORT:-11434}"

export OLLAMA_HOST="0.0.0.0:${PORT}"

ollama serve &
SERVE_PID=$!

for i in {1..60}; do
  if curl -fsS "http://127.0.0.1:${PORT}/api/tags" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

ollama pull "${MODEL}"

wait "${SERVE_PID}"
