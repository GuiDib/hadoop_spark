# Relatório – Laboratório Hadoop e Spark

## Identificação
**Curso:** Engenharia de Software – PSPD  
**Professor:** Fernando W. Cruz  
**Aluno(s):** 
- Pedro Henrique Nogueira Bragança  
- 

**Data:** 14/11/2025

## 1. Introdução
O objetivo desta atividade é explorar os conceitos de Big Data e processamento distribuído através da experimentação prática com dois dos principais frameworks do ecossistema: Apache Hadoop e Apache Spark.

Este relatório documenta as etapas de configuração, teste e análise de um cluster Hadoop (Item B1), focado em sua arquitetura, escalabilidade e tolerância a falhas.


## 2. Experimento com Apache Hadoop

### 2.1. Arquitetura e Configuração

Para atender aos requisitos do Item B1, o cluster Hadoop foi estabelecido em modo **pseudo-distribuído** (multi-nó lógico em um único host) utilizando **Docker e Docker Compose**. A arquitetura simula um ambiente de produção com separação de responsabilidades em uma rede bridge (`hadoop`):

* **Nós Mestre (2 Contêineres):**
    * `namenode`: Mestre do **HDFS** (Gerenciamento de metadados).
    * `resourcemanager`: Mestre do **YARN** (Gerenciamento e Escalonamento de Jobs).
* **Nós Escravos (4 Contêineres - 2 Nós de Trabalho):**
    * `datanode1` + `nodemanager1`
    * `datanode2` + `nodemanager2`

***

### 2.2. Experimentos e Configuração para Comportamento (5 Alterações)

Para validar e documentar o comportamento do *framework*, foram aplicadas as seguintes configurações essenciais nos arquivos `mapred-site.xml` e `yarn-site.xml` :

| Cenário | Propriedade Alterada | Valor Adotado | Impacto Observado | Componente Principal |
| :--- | :--- | :--- | :--- | :--- |
| **1. Framework Base** | `mapreduce.framework.name` | `yarn` | **Funcionalidade:** Garantiu a submissão correta dos jobs ao YARN (modo distribuído). | Escalonador |
| **2. Serviço de Shuffle** | `yarn.nodemanager.aux-services.mapreduce_shuffle.class` | `org.apache.hadoop.mapred.ShuffleHandler` | **Correção Crítica:** Corrigiu o erro `InvalidAuxServiceException` e habilitou a fase **Reduce** nos *workers*. | YARN Daemon |
| **3. Endereço do Gerente** | `yarn.resourcemanager.hostname` | `resourcemanager` | **Conectividade:** Permitiu que todos os nós se registrassem, resultando em **`Total Nodes:2`** no monitor YARN. | Rede/YARN |
| **4. HDFS Block Size** | `dfs.blocksize` | 134217728 (128 MB) | **Otimização:** Forçou a divisão do arquivo de 2 GB em **16 *splits***, maximizando o paralelismo. | HDFS |
| **5. Ambiente de Task** | `mapreduce.map.env` | `/opt/hadoop-3.2.1` | **Operacional:** Definiu as variáveis de ambiente necessárias para a correta inicialização dos *containers* Map. | MapReduce |

***

### 2.3. Testes de Tolerância a Falhas

O teste de resiliência foi conduzido em um job de **WordCount** com **2 GB de dados**, que teve um tempo base de **2m04s**.

| Ação de Falha | Observação Principal no YARN Web UI | Consequência | Contadores (Evidência) |
| :--- | :--- | :--- | :--- |
| **Base** | `Total Nodes:2` (Nós ativos). Job Map/Reduce em andamento. | Tempo Base: **2m04s**. | `Launched map tasks`: 16 (iniciais) |
| **Falha** | Comando: `docker stop nodemanager1` (em ~31% de Map). | O nó `nodemanager1` foi marcado como **LOST**. O cluster perdeu 50% da sua capacidade. | O YARN detecta e re-aloca tarefas. |
| **Recuperação** | O `ResourceManager` re-escalona as tarefas perdidas para o `nodemanager2`. | O job continua, utilizando apenas o nó remanescente. | `Launched map tasks`: **18** (as 2 extras são as tarefas re-alocadas). |
| **Conclusão** | Job finalizado 100% (com sucesso). | O tempo total de execução foi estendido, mas a integridade dos dados foi mantida. | `Total time spent by all map tasks`: **377,633 ms** (o tempo extra gasto na re-execução). |

***

### 2.4. Resultados e Conclusões

| Tópico | Conclusão | Comentários |
| :--- | :--- | :--- |
| **Tolerância a Falhas** | **Suportada e Comprovada.** | O YARN demonstrou resiliência. O job de 2 GB foi concluído com sucesso mesmo após a **perda abrupta de um nó de trabalho** (`nodemanager1`). O **ResourceManager** orquestrou a re-alocação automática das tarefas. |
| **Melhoria de Desempenho** | **Comprovada.** | A divisão do arquivo em múltiplos *splits* e a execução paralela em 2 nós (`datanode1` e `datanode2`) resultou em um tempo de **2m04s**, significativamente menor do que seria com um nó único. |
| **Vantagens/Desvantagens** | | |
| **Vantagens** | **Resiliência e Escalabilidade.** | A principal vantagem é a capacidade de **não perder dados** e **não interromper o processamento** diante de falhas. A performance cresce linearmente com a adição de nós. |
| **Desvantagens** | **Complexidade Operacional.** | A principal desvantagem é a **sobrecarga de gerenciamento** e a complexidade na configuração inicial em ambientes conteinerizados, exigindo intervenções de baixo nível (como visto na depuração). |

**Conclusão Final:** O ambiente Hadoop/YARN se provou robusto e adequado para processamento de Big Data, cumprindo os objetivos do laboratório ao demonstrar **escalabilidade** e **resiliência a faltas**.

## 3. Experimento com Spark
- Configuração e ferramentas
- Consumo de dados
- Visualização dos resultados
- Dificuldades e aprendizados

## 4. Conclusão
- Comparação entre Hadoop e Spark
- Reflexões individuais dos integrantes

## 5. Anexos
- Configurações
- Prints e gráficos
- Comandos utilizados
