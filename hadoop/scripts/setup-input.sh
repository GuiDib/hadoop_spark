#!/bin/bash
set -e

echo '📂 Criando diretório de entrada e arquivos grandes para teste...'

# 1. Criar pasta input se não existir
mkdir -p input

# 2. Gerar arquivo de texto ENORME (2048 MB) para teste de performance
# (2048 * 1024 * 1024 bytes) = ~2 GB
FILE_SIZE_BYTES=$((2048 * 1024 * 1024))
OUTPUT_FILE="input/large_input.txt"

if [ ! -f "$OUTPUT_FILE" ] || [ $(stat -c%s "$OUTPUT_FILE") -lt $FILE_SIZE_BYTES ]; then
    echo "Gerando arquivo ENORME ($FILE_SIZE_BYTES bytes). Isso vai demorar..."
    # Usando dd para garantir o tamanho (mais rápido que base64 para este volume)
    # Mas vamos manter o base64 para garantir que seja TEXTO, não binário
    base64 /dev/urandom | head -c $FILE_SIZE_BYTES > "$OUTPUT_FILE"
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