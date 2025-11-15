#!/bin/bash
set -e
echo '🛑 Parando e removendo cluster Hadoop...'

docker compose down

echo '✅ Cluster parado e removido.'