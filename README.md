# Estudo de Caso: Análise do Sistema de Compartilhamento de Bicicletas

Esse projeto é um estudo de caso para conclusão do curso de Certificado Profissional de Análise de Dados do Google. No cenário deste estudo de caso, eu sou um Analista de Dados Júnior trabalhando em uma equipe de analistas de marketing na Cyclistic, uma empresa de compartilhamento de bicicletas em Chicago.

Para mais detalhes sobre o projeto consulte o documento original do estudo de caso do Google disponível [aqui](./docs/case_study.pdf).

## Declaração do Objetivo de Negócio

Os analistas financeiros da Cyclist concluíram que os membros anuais são significativamente mais lucrativos do que os ciclistas casuais. Portanto, almejando um crescimento futuro da empresa, foi definido o objetivo de maximizar o número de membros anuais.

Para atingir esse objetivo, será realizado uma análise dos dados para identificar as principais diferenças nos padrões de uso das bicicletas Cyclistic entre ciclistas casuais e membros anuais.

Os insights obtidos revelarão padrões de comportamento e preferências entre ciclistas casuais e membros anuais, permitindo a criação de estratégias de marketing direcionadas com maior chance de engajamento e conversão.

## Descrição dos Dados

Os dados utilizados nesse projeto são disponibilizados publicamente pela [Divvy](https://divvybikes.com/about), o sistema oficial de bicicletas compartilhadas da cidade de Chicago, operado atualmente pela Lyft.

A Divvy publica mensalmente dados de viagens para uso público por meio de seu [site oficial](https://divvybikes.com/system-data), sob os termos do seu [Acordo de Licença de Uso dos Dados](https://divvybikes.com/data-license-agreement).

Os arquivos são hospedados em um repositório S3 acessível via [este link direto](https://divvy-tripdata.s3.amazonaws.com/index.html), que foi utilizado como fonte dos dados empregados neste projeto.

### Os Dados

Os dados estão no formato `.csv`, com estrutura tabular — cada arquivo contém observações em linhas e variáveis em colunas.

Cada registro representa uma viagem anonimizada, incluindo:

-   Dia e hora do início da viagem
-   Dia e hora do fim da viagem
-   Estação de início da viagem
-   Estação final da viagem
-   Tipo de ciclista (membro e casual)

Segundo a Divvy, os dados foram processados para remover viagens feitas pelos funcionários enquanto eles fazem a manutenção e inspecionam o sistema; e qualquer viagem com duração inferior a 60 segundos — consideradas como falsos inícios ou tentativas de reencaixe da bicicleta na estação.

A Divvy disponibiliza dados de viagens desde o início de suas operações em 2013, com atualizações mensais contínuas. Neste projeto, serão utilizados os 12 datasets mais recentes disponíveis até o momento, abrangendo o período de junho de 2024 a maio de 2025.

Devido ao seu tamanho, os arquivos não serão incluídos no repositório. Para utilizá-los localmente, siga as instruções abaixo para baixar os dados:

-   [Acesse os dados do histórico de viagens da Divvy](https://divvy-tripdata.s3.amazonaws.com/index.html)
-   Baixe os arquivos `.zip` de junho de 2024 até maio de 2025
    -   Os arquivos seguem a nomenclatura "yyyymm-divvy-tripdata.zip", onde "yyyy" representa o ano e "mm" o mês de referência. Por exemplo: 202408-divvy-tripdata.zip corresponde aos dados de agosto de 2024.
-   Extraia os arquivos `.zip` em uma pasta `data_raw/`

## Pré-processamento e Limpeza de Dados

A etapa de pré-processamento e limpeza de dados foi conduzida com a linguagem R para facilitar a exploração e manipulação dos dados.

Para efetuar a limpeza do dataset foram efetuadas as seguintes etapas:

-   Pré-processamento
    -   Import dos dados
    -   Exploração dos dados
-   Limpeza dos Dados
    -   Verificação do intervalo de datas
    -   Tratamento de dados ausentes
    -   Verificação de variáveis categóricas
    -   Tratamento de dados duplicados
    -   Formatação de strings
    -   Adição de colunas derivadas
    -   Verificação da duração das viagens
-   Salvando o Dataset Tratado

O processo completo está documentado no arquivo [`data_cleaning.Rmd`](data_cleaning/data_cleaning.Rmd). Para mais detalhes sobre alterações e decisões, consulte também o [log de mudanças](data_cleaning/changelog.md).


## Exploração e Análise de Dados

Na etapa de limpeza, os datasets mensais foram incorporados em um único dataset, visto que todos possuem a mesma estrutura. O tamanho do arquivo `.csv` gerado 
