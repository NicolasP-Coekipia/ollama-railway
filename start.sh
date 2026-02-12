#!/usr/bin/env bash
set -euo pipefail

MODEL="${MODEL_NAME:-gpt-oss:20b}"
PORT="${PORT:-11434}"

# Bind réseau + port Railway
export OLLAMA_HOST="0.0.0.0:${PORT}"

echo "[boot] starting ollama on ${OLLAMA_HOST}"
ollama serve &
SERVE_PID=$!

# Attendre que l’API réponde
echo "[boot] waiting for ollama API..."
for i in {1..60}; do
  if curl -fsS "http://127.0.0.1:${PORT}/api/tags" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "[boot] pulling model: ${MODEL}"
ollama pull "${MODEL}"

echo "[boot] ready"
wait "${SERVE_PID}"

