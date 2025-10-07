#!/usr/bin/env bash
set -e
URL=${1:-http://localhost:3000/api/health}
echo "Testing $URL ..."
curl -fsS $URL | python -m json.tool
echo "OK"
