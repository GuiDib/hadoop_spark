docker-compose up -d --platform linux/amd64#!/bin/bash
set -e

echo '📂 Criando diretório de entrada e arquivos grandes para teste...'

# 1. Criar pasta input se não existir
mkdir -p input


# 2. Gerar arquivo de texto ENORME (2048 MB) para teste de performance
# (2048 * 1024 * 1024 bytes) = ~2 GB
FILE_SIZE_BYTES=$((2048 * 1024 * 1024))
OUTPUT_FILE="input/large_input.txt"

# Detecta sistema operacional para usar o comando stat correto
if [[ "$(uname)" == "Darwin" ]]; then
    STAT_CMD="stat -f%z"
else
    STAT_CMD="stat -c%s"
fi

FILE_SIZE=0
if [ -f "$OUTPUT_FILE" ]; then
    FILE_SIZE=$($STAT_CMD "$OUTPUT_FILE")
fi

if [ ! -f "$OUTPUT_FILE" ] || [ "$FILE_SIZE" -lt "$FILE_SIZE_BYTES" ]; then
    echo "Gerando arquivo ENORME ($FILE_SIZE_BYTES bytes). Isso vai demorar..."
    # Gera 2GB de dados aleatórios e converte para texto base64
    dd if=/dev/urandom bs=1m count=2048 2>/dev/null | base64 > "$OUTPUT_FILE"
    echo "✅ Arquivo $OUTPUT_FILE criado com sucesso!"
else
    echo "✅ Arquivo $OUTPUT_FILE já existe e tem o tamanho correto."
fi

# 3. Criar o sample.txt (se for o caso)
if [ ! -f input/sample.txt ]; then
    cat > input/sample.txt << 'EOF'
hadoop hdfs mapreduce hadoop yarn
spark hadoop hdfs spark
hadoop yarn mapreduce yarn hadoop
datanode namenode hadoop hadoop
container yarn resourcemanager container
EOF
    echo "✅ Arquivo input/sample.txt criado"
fi

echo "✅ Entrada preparada!"