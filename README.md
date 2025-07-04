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

O processo completo está documentado no arquivo [`data_cleaning.Rmd`](data_cleaning/data_cleaning.Rmd), com a versão renderizada em [.md](data_cleaning/data_cleaning.md). Para mais detalhes sobre alterações e decisões, consulte também o [log de mudanças](data_cleaning/changelog.md).

## Exploração e Análise de Dados

Na etapa de limpeza, os datasets mensais foram combinados em um único dataset, visto que todos possuem a mesma estrutura. O tamanho do arquivo `.csv` gerado ultrapassou 1GB, impossibilitando o seu upload direto no BigQuery.

Para solucionar essa limitação o arquivo foi armazenado em um bucket no Google Cloud Storage, facilitando o acesso e o processamento dos dados na nuvem. O armazenamento na nuvem possibilitou efetuar o carregamento dos dados do repositório, no Google Cloud Storage, para o BigQuery.

A análise dos dados foi aplicada utilizando a linguagem SQL para manipulação e consultas complexas do conjunto de dados a fim de extrair insights relacionados aos padrões de uso das bicicletas entre ciclistas casuais e membros anuais. O processo completo da análise e os principais insights identificados estão documentados no arquivo disponível [aqui](data_analysis/README.md).

## Visualizações e Principais Descobertas

No curso de Análise de Dados do Google, a ferramenta de visualização apresentada é o Tableau. No entanto, por preferência pessoal e pela ausência de suporte a conexão com o BigQuery do Tableau Public Desktop, as visualizações desse projeto foram desenvolvidas utilizando o Microsoft Power BI.

O objetivo do dashboard é identificar padrões de uso das bicicletas compartilhadas da Divvy, com foco em comportamentos distintos entre ciclistas casuais e membros anuais. A visualização foi contruída a partir do dataset extraído do repositório oficial da Divvy, abrangendo o período de junho de 2024 a maio de 2025, o qual, no decorrer desse projeto, foi limpo e tratado em R, exportado ao BigQuery e conectado ao Power BI.

As principais métricas apresentadas no dashboard, com foco em uma análise comparativa entre os tipos de usuários, estão descritas abaixo:

-   **Total de Viagens**: Quantidade total de viagens realizadas.
-   **Duração Média**: Tempo médio por viagem.
-   **Duração Média Mensal e Semanal**: Matriz que exibe o tempo médio mensal e semanal por viagem.
-   **Viagens por Mês**: Distribuição mensal das viagens.
-   **Viagens por Dia da Semana**: Frequência semanal de viagens por tipo de usuário.
-   **Viagens por Horário do Dia**: Horários de pico de viagens por tipo de usuário.
-   **Viagens por Tipo de Transporte**: Preferência entre bicicletas clássicas, elétricas e scooters.

O dashboard permite interação dinâmica por tipo de usuário, possibilitando alternar a visualização dos gráficos entre ciclistas casuais, membros ou visão geral.

### Estilo e Design

A paleta de cores utilizada no dashboard foi inspirada na identidade visual da Divvy. A tela de fundo, criada no PowerPoint, é um gradiente que tem como base o tom de azul (`#3CB4E5`) presente na logo da Divvy.

Os gráficos foram coloridos com cores harmoniosas e variações do azul da Divvy. As cores foram selecionadas a partir de paletas geradas em [color-hex.com](https://www.color-hex.com/) e [mycolor.space](https://mycolor.space/). O ciclista membro é representado por um tom de verde vibrante (`#B4E53C`), enquanto o ciclista casual é identificado pelo verde água claro (`#62ECAF`). Esta última também foi usada como base para o gradiente que realça os meses e dias da semana com maior duração média na matriz de análise temporal.

Para manter contraste visual adequado, o texto e ícones (obtidos em: [flaticon.com](https://www.flaticon.com/)) foram aplicados na cor branca.

O storytelling do dashboard segue o conceito de leitura em "Z", no qual os olhos percorrem a tela da esquerda para a direita e de cima para baixo. Os elementos visuais foram organizados de forma a apresentar as informações mais relevantes primeiro, guiando o usuário de maneira intuitiva.

A escolha estética visa reforçar a identidade visual da Divvy enquanto garante clareza e acessibilidade na apresentação das informações, como ilustrado na imagem abaixo.

![image](https://github.com/user-attachments/assets/1dabea25-0e58-4178-b48e-9ad4d41a333e)

### Insights

Ao analisar o dashboard é possível extrair insights chaves, que destacam as principais diferenças nos padrões de comportamento dos ciclistas casuais e membros anuais.

-   A duração média de viagem dos **ciclistas casuais (\~ 19 minutos)** é relativamente maior que dos **membros (\~ 12 minutos)**.

-   A frequência de uso do serviço é maior no período entre **junho e outubro**, o que coincide com os meses mais quentes e agradáveis em Chicago. A duração média das viagens apresentam um comportamento similar.

-   O comportamento semanal dos usuários é **oposto**: enquanto os **membros** tendem a usar o serviço com maior frequência nos **dias úteis**, os usuários **casuais** são predominantemente mais ativos nos **fins de semana**.

-   O horário de pico de ambos os usuários é por volta de **14 até 18 horas**. Porém, os **membros** também realizam um volume significativo de viagens no **início da manhã**, às 8:00.

O comportamento de uso do serviço nos fins de semana em conjunto com a duração média de viagem superior, indica um perfil **recreativo** para os ciclistas **casuais**.

Já a alta frequência de viagens nos dias úteis e nos horários de início da manhã e fim da tarde, aponta que os ciclistas **membros** utilizam o serviço como **meio de transporte**.

### Acesso e Compartilhamento

O dashboard foi publicado no Power BI Service e está disponível publicamente na web. Para acessar e interagir com o dashboard clique [aqui](https://app.powerbi.com/view?r=eyJrIjoiMWU4MmQ5Y2EtYjU2Mi00Y2RmLTkzYzUtNDEzMTZjZjk1NTNiIiwidCI6ImJhZTkwYjYxLTg4OTItNDQyMC1hMTEyLTE0NTQ4MzBkYmJiOSJ9).

## Recomendações Estratégicas

Para esta última etapa e finalização do projeto, o estudo de caso pede três recomendações principais baseadas nos resultados da análise. Essas recomendações buscam estar diretamente alinhadas com o objetivo principal do projeto, que é engajar e converter os ciclistas casuais em membros anuais.

1.  As campanhas de marketing deverão ser lançadas durante o verão (junho a outubro) direcionada aos ciclistas casuais, com foco em lazer e turismo.

2.  Usar dos fins de semana e feriados para promover o plano anual com benefícios extras.

3. Incorporar ao plano anual um sistema de recompensas baseado em número e/ou duração de viagens.

## Considerações Finais

Esse estudo de caso integra todo o ciclo de um projeto de análise de dados seguindo os passos fornecidos pelo Certificado Profissional de Análise de Dados do Google: **Ask**, **Prepare**, **Analyze**, **Share** e **Act**. Através destas etapas, foi conduzida uma análise detalhada de mais de 5 milhões de registros de viagens com bicicletas compartilhadas da Divvy. Essa análise permitiu identificar padrões de comportamento entre os ciclistas casuais e anuais, gerando insights com potencial para orientar decisões de negócio.

Este projeto consolidou minha capacidade de aplicar técnicas de análise de dados em um cenário real, com foco em geração de valor para o negócio.