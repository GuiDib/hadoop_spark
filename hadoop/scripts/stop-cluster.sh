#!/bin/bash
echo '🛑 Parando cluster Hadoop...'
docker exec -it namenode stop-yarn.sh
docker exec -it namenode stop-dfs.sh
docker-compose down
echo '✅ Cluster parado com sucesso!'
