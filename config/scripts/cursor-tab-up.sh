#!/usr/bin/env bash


THREADS=$(lscpu -p=Core,Socket | grep -v '^#' | sort -u | wc -l)  # physical cores

start() { # name, port, hf-model
  if curl -sf "http://127.0.0.1:$2/health" >/dev/null; then
    echo "$1: already up on $2"
    return
  fi
  nohup llama serve -hf "$3" --host 127.0.0.1 --port "$2" \
    --ctx-size 4096 --cache-reuse 256 --parallel 1 \
    --threads "$THREADS" \
    >"/tmp/llama-$1.log" 2>&1 &
}

start inline 8101 "ggml-org/Qwen3.5-0.8B-GGUF:Q8_0"
start sweep  8102 "sweepai/sweep-next-edit-1.5B:V2"

# for port in 8101 8102; do
for port in 8101; do
  for _ in $(seq 120); do
    curl -sf "http://127.0.0.1:$port/health" >/dev/null && break
    sleep 1
  done
  curl -sf "http://127.0.0.1:$port/health" >/dev/null && echo "up: $port" || echo "FAILED: $port (see /tmp/llama-*.log)"
done
