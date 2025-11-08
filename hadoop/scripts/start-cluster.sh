#!/bin/bash
echo '🚀 Iniciando cluster Hadoop...'
docker-compose up -d
docker exec -it namenode hdfs namenode -format
docker exec -it namenode start-dfs.sh
docker exec -it namenode start-yarn.sh
echo '✅ Cluster iniciado com sucesso!'
