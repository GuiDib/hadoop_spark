#!/bin/bash
echo '📘 Executando WordCount no Hadoop...'
INPUT_DIR=/user/input
OUTPUT_DIR=/user/output

docker exec -it namenode hdfs dfs -mkdir -p $INPUT_DIR
docker exec -it namenode hdfs dfs -put /hadoop/dfs/input/* $INPUT_DIR

docker exec -it namenode hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar wordcount $INPUT_DIR $OUTPUT_DIR

docker exec -it namenode hdfs dfs -cat $OUTPUT_DIR/part-r-00000 | head -20
echo '✅ WordCount executado!'
