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

O ambiente Spark foi configurado em modo cluster, dentro do Google Colab. Foram integrados serviços como Kafka para processamento e visualização de dados em tempo real. As principais etapas do experimento incluíram:

- Instalação do Spark e configuração das variáveis de ambiente.
- Integração do Spark Streaming com Kafka para ingestão de dados.
- Utilização do dataset IMDb via Hugging Face para simular um fluxo de dados real.
- Processamento de dados em tempo real com Spark Structured Streaming, contabilizando palavras recebidas do Kafka.

Scripts e comandos utilizados estão detalhados no notebook `SPARK_FINAL.ipynb`.

### Dificuldades e Aprendizados

- Ajuste de parâmetros de memória e número de executores para otimizar o processamento.
- Integração com Kafka e ElasticSearch exigiu atenção especial à configuração de redes e permissões entre contêineres.
- O uso do Google Colab apresentou instabilidades, especialmente na integração com serviços locais e na execução de daemons.
- Aprendizado sobre o modelo de execução distribuída do Spark, suas APIs de streaming e diferenças em relação ao Hadoop.

### Resultados

- O Spark apresentou excelente desempenho em processamento distribuído e integração com outras ferramentas do ecossistema Big Data.
- A flexibilidade do Spark para diferentes workloads (batch e streaming) foi um diferencial.
- A visualização dos resultados em tempo real via Kibana permitiu acompanhar o processamento e contabilização das palavras do fluxo de dados.

---

## 3. Conclusão

### Opinião dos Alunos

1. **Bruno Henrique Cardoso:** Trabalhei na implementação do Apache Spark e na integração com Kafka para streaming de dados. A configuração inicial do Spark foi desafiadora, especialmente ao ajustar os parâmetros de memória e executores para otimizar o desempenho. O Kafka mostrou-se eficiente para o processamento de streams em tempo real, mas exigiu atenção especial na configuração de tópicos e partições. Apesar das dificuldades iniciais, consegui observar na prática as vantagens do processamento distribuído.
2. **Guilherme Dib França:* Desenvolver esse projeto trouxe uma visualização e compreensão de como organizar de uma forma eficiente os containeres do docker e como facilitar as execuções de testes mediante alguns scripts em shell, ajudou a encapsular serviços para facilitar a montagem do clusters utilizando uma menor quantidade de recursos e sem instalar nada diretamente na máquina facilitando a testar conceitos do HDFS por exemplo. Rodar o exemplo WordCount e preparar inputs (sample.txt, large_input.txt) tornou claro o fluxo básico: ingestão de dados → processamento distribuído → coleta de saída em HDFS. *
3. **João Gabriel Elvas:**
   Participei ativamente da implementação e configuração da parte do Hadoop no projeto. Aprendi bastante sobre o processamento de dados distribuídos e como o ecossistema funciona. Achei a etapa que envolvia o Google Colab um pouco complicada, pois ele falhava com frequência e apresentava instabilidades. Por conta disso, preferimos seguir utilizando o Docker, que nos proporcionou um ambiente mais estável e controlado para o desenvolvimento.
4. **Pedro Henrique Nogueira:** Este trabalho me proporcionou um aprendizado prático e intenso sobre a complexidade e a resiliência dos sistemas distribuídos de Big Data. O maior desafio não foi apenas montar o cluster, mas sim dominar a depuração de baixo nível para resolver o conflito entre o Docker e o Hadoop. Aprendi que, na prática, a tolerância a falhas não é teórica: ela é uma funcionalidade que exige a configuração perfeita dos daemons YARN. Ao forçar a perda de 50% dos recursos (nodemanager1), comprovei que o sistema é capaz de se auto-curar e completar o processamento, confirmando a principal vantagem do Hadoop: garantir a conclusão e a integridade dos dados mesmo sob falhas críticas.

---

## 4. Apêndice/Anexo 

- Links úteis:
  - [Apache Hadoop](https://hadoop.apache.org/docs/stable/)
  - [Apache Spark](https://spark.apache.org/docs/latest/)
