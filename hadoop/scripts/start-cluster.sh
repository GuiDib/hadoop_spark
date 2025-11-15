#!/bin/bash
set -e

echo '🚀 Iniciando cluster Hadoop (HDFS + YARN)...'

docker compose up -d

echo "[Passo 1/3] Aguardando 20s para o cluster estabilizar..."
sleep 20

echo "[Passo 2/3] Verificando status dos DataNodes..."
docker exec namenode hdfs dfsadmin -report

echo "[Passo 3/3] Aguardando mais 10s para NodeManagers se registrarem..."
sleep 10

echo '✅ Cluster iniciado com sucesso!'
echo '---'
echo 'Acesse as interfaces Web:'
echo 'HDFS (NameNode): http://localhost:9870'
echo 'YARN (ResourceManager): http://localhost:8088'
echo '---'