# Atividade Extraclasse: Experimentação com Hadoop e Spark

**Curso:** Engenharia de Software
**Disciplina/Turma:** Programação para Sistemas Paralelos e Distribuídos (PSPD) – UnB/FCTE  
**Professor:** Fernando W. Cruz  
**Aluno(s):**

1. Bruno Henrique Cardoso - 190134275
2. Guilherme Dib França - 190108088
3. João Gabriel Elvas - 190109599
4. Pedro Henrique Nogueira - 190094478

---

## Introdução

Esta atividade extraclasse tem como objetivo proporcionar uma experimentação prática dos frameworks Apache Hadoop. O relatório apresenta a montagem dos ambientes, os experimentos realizados e as principais conclusões e aprendizados obtidos.

---

## 1. Experimento com Apache Hadoop

### Arquitetura e Configuração

O cluster Hadoop foi montado utilizando contêineres Docker, simulando um ambiente distribuído com um nó mestre (NameNode) e dois nós escravos (DataNode1, DataNode2), além dos serviços de ResourceManager e NodeManagers para orquestração via YARN. As principais configurações estão nos arquivos:

- `docker-compose.yml`: define os serviços e volumes do cluster
- `config/mapred-site.xml` e `config/yarn-site.xml`: parâmetros de execução e escalonamento

Interfaces web disponíveis para monitoramento:

- HDFS (NameNode): http://localhost:9870
- YARN (ResourceManager): http://localhost:8088

### Experimentos de Performance e Tolerância a Falhas

#### Performance

Foi executada a aplicação WordCount sobre um arquivo de texto de aproximadamente 3GB, utilizando o paradigma MapReduce. Foram realizadas pelo menos 5 alterações nos parâmetros do cluster (memória, número de containers, replicação, etc.) para observar o impacto no tempo de execução e uso de recursos.

#### Tolerância a Falhas

Durante a execução do WordCount, foram simuladas falhas controladas (parada e reinício de DataNodes/NodeManagers) para avaliar o comportamento do Hadoop e a resiliência da aplicação. Os resultados foram monitorados via interface web e documentados quanto ao tempo de resposta e manutenção da execução.

#### Resultados

- O acréscimo de nós pode melhorar o desempenho, desde que haja recursos suficientes.
- O Hadoop demonstrou tolerância a falhas, mantendo a execução do job mesmo com a indisponibilidade temporária de alguns nós.

---

## 2. Experimento com Apache Spark

### Arquitetura e Configuração

### Dificuldades e Aprendizados

### Resultados

---

## 3. Conclusão

### Opinião dos Alunos

**Bruno Henrique Cardoso:**
**Guilherme Dib França:**
**João Gabriel Elvas:**
**Pedro Henrique Nogueira:**

---

## 4. Apêndice/Anexo (Opcional)

- Arquivos de configuração: `docker-compose.yml`, scripts de inicialização e execução.
- Comentários sobre os códigos construídos e instruções detalhadas de execução estão disponíveis nos READMEs das pastas.
- Links úteis:
  - [Apache Hadoop](https://hadoop.apache.org/docs/stable/)
  - [Apache Spark](https://spark.apache.org/docs/latest/)
