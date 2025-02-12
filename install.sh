#!/bin/bash
set -euo pipefail

# echo "== Installing dependencies =="

# # For macOS (Homebrew)
# if command -v brew &> /dev/null
# then
#     brew install terraform awscli docker kind kubectl helm localstack checkov
# else
#     echo "Please install Homebrew or install the following tools manually: terraform, awscli, docker, kind, kubectl, helm."
# fi

# # (Optional) Install Node.js if not already installed.
# if ! command -v node &> /dev/null
# then
#     echo "Please install Node.js manually."
# fi

echo "== Installing Prometheus & Grafana in Docker (for local monitoring) =="
docker run -d -p 9090:9090 --name prometheus prom/prometheus || true
docker run -d -p 3000:3000 --name grafana grafana/grafana || true

echo "Dependencies installed!"
