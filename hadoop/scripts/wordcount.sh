#!/bin/bash
set -e

echo '📘 Preparando e executando WordCount no Hadoop (MODO YARN)...'

INPUT_DIR=/user/input
OUTPUT_DIR=/user/output
# --- MUDANÇA AQUI: USAR O ARQUIVO GRANDE ---
INPUT_FILE_LOCAL_PATH=input/large_input.txt
INPUT_FILE_HDFS_PATH=$INPUT_DIR/large_input.txt
# --------------------------------------------

# Limpar output anterior se existir
echo "Limpando output anterior..."
docker exec namenode hdfs dfs -rm -r $OUTPUT_DIR 2>/dev/null || true

# Criar diretórios
echo "Criando diretórios HDFS..."
docker exec namenode hdfs dfs -mkdir -p $INPUT_DIR

# Copiar dados de entrada
echo "Copiando dados grandes para HDFS. Isso pode demorar..."
# O docker-compose monta ./input (host) para /input (container)
# Usamos o caminho absoluto /input/large_input.txt DENTRO do container
docker exec namenode hdfs dfs -put -f /input/large_input.txt $INPUT_FILE_HDFS_PATH

# Verificar dados copiados
echo "Verificando dados no HDFS:"
docker exec namenode hdfs dfs -ls $INPUT_DIR/

# Executar WordCount (FORÇANDO O MODO YARN)
echo "Executando aplicação MapReduce no YARN (Monitorar em http://localhost:8088)..."

# Este comando iniciará o job e aguardará o fim (o monitoramento em tempo real é feito no navegador)
# A flag -it foi removida para garantir que o 'time' funcione corretamente após a execução do docker exec
time docker exec namenode yarn jar \
  /opt/hadoop-3.2.1/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar \
  wordcount $INPUT_FILE_HDFS_PATH $OUTPUT_DIR

# Exibir resultado
echo ""
echo "✅ WordCount executado! Job concluído."
echo "--- Amostra do Resultado ---"
# Exibimos apenas o início do arquivo para não encher o terminal com 256MB de contagens
docker exec namenode hdfs dfs -cat $OUTPUT_DIR/part-r-00000 | head -n 20