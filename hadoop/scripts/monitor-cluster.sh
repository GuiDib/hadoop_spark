#!/bin/bash

echo '📊 Monitorando status do Cluster Hadoop...'
echo ""

echo "=== HDFS Status ==="
docker exec namenode hdfs dfsadmin -report

echo ""
echo "=== YARN Nodes ==="
docker exec resourcemanager yarn node -list -all

echo ""
echo "=== Aplicações YARN ==="
docker exec resourcemanager yarn application -list -appStates ALL