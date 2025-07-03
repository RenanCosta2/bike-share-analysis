# Análises SQL no Big Query

Este arquivo contém as consultas SQL utilizadas para a análise do estudo de caso, executadas diretamente no Google BigQuery. O objetivo dessa análise é identificar os padrões de uso das bicicletas entre ciclistas casuais e membros anuais.

## Consultas Disponíveis

As consultas abaixo foram estruturadas a fim de realizar uma análise exploratória e estatística dos dados, organizadas nas seguintes vertentes principais:

-   Duração das viagens
-   Quantidade de viagens
-   Padrões temporais
-   Estações

### Duração de Viagens

-   [`avg_max_duration.sql`](querys/duration/avg_max_duration.sql) - Retorna a duração média e a máxima das viagens.

-   [`avg_duration_by_user.sql`](querys/duration/avg_duration_by_user.sql) - Retorna a duração média das viagens por tipo de ciclista.

-   [`avg_duration_by_rideable_type.sql`](querys/duration/avg_duration_by_rideable_type.sql) - Retorna a duração média das viagens por tipo de transporte.

-   [`avg_duration_by_user_per_month.sql`](querys/duration/avg_duration_by_user_per_month.sql) - Retorna a duração média das viagens por tipo de ciclista em cada mês.

-   [`avg_duration_by_user_per_weekday.sql`](querys/duration/avg_duration_by_user_per_weekday.sql) - Retorna a duração média das viagens por tipo de ciclista nos dias da semana.

### Quantidade de Viagens

-   [`trips_per_weekday.sql`](querys/trip_counts/trips_per_weekday.sql) - Retorna o número de viagens por dias da semana.

-   [`trips_by_user_per_weekday.sql`](querys/trip_counts/trips_by_user_per_weekday.sql) - Retorna o número de viagens por dia da semana para cada tipo de ciclista.

-   [`trips_by_user_per_rideable_type.sql`](querys/trip_counts/trips_by_user_per_rideable_type.sql) - Retorna o número de viagens por tipo de transporte para cada tipo de ciclista.

-   [`trips_by_user_per_month.sql`](querys/trip_counts/trips_by_user_per_month.sql) - Retorna o número de viagens por tipo de ciclista em cada mês.

### Padrões Temporais

-   [`peak_hours_by_user.sql`](querys/time_patterns/peak_hours_by_user.sql) - Retorna os horários de pico para cada tipo de ciclista.

### Estações

-   [`top_stations_overall.sql`](querys/stations/top_stations_overall.sql) - Retorna as estações mais populares.

-   [`top_stations_by_user.sql`](querys/stations/top_stations_by_user.sql) - Retorna as estações mais populares para cada tipo de ciclista.

Os resultados para cada uma dessas consultas foram separados e organizados em formato `JSON` na pasta de [outputs](outputs).

## Resumo das Análises

Durante o período analisado (junho/2024 a maio/2025), foram processadas e analisadas mais de 5 milhões de viagens realizadas com bicicletas compartilhadas da Divvy. Abaixo estão os principais insights obtidos:

### Padrões Temporais

- Ambos os usuários tendem a utilizar o serviço com maior frequência entre os meses de **junho e outubro**.

- Nos meses entre **dezembro e fevereiro**, a **quantidade de viagens realizadas decai** consideravelmente.

- Os **casuais** tendem a utilizar o serviço com **maior frequência no período da tarde**, entre 14 e 18 horas. 
Os **membros** têm um comportamento similar, porém também realizam um volume significativo de viagens no **início da manhã**, às 8:00.

### Duração das Viagens

-   A duração média foi de **14:30 minutos**, que são viagens relativamente curtas, indicando que utilizam o serviço para percorrer pequenas distâncias. No entanto, a **duração máxima** observada foi próxima ao limite imposto na etapa de limpeza dos dados, de aproximadamente **4 horas**.

- A **duração média mensal das viagens** tem um comportamento similar aos padrões temporais identificados na frequência de viagens mensais.

- Viagens com **bicicletas clássicas** tendem a ser mais longas do que com **bicicletas elétricas/scooters**.

- As viagens de maior duração acontecem nas **sextas-feiras e nos fins de semana**.

### Perfil de Uso por Usuário

- A duração média de viagem dos **ciclistas casuais (~ 19 minutos)** é relativamente maior que dos **membros (~ 12 minutos)**.

- Os **casuais** usam predominantemente o serviço aos **fins de semana**, indicando um perfil recreativo.

- Os **membros** apresentam o comportamento oposto, no qual a **predominância do uso são nos dias úteis** e os **dias com menos viagens são nos finais de semana**, apontando um uso do serviço como meio de transporte.

### Tipo de Transporte Utilizado

- O tipo de transporte **mais utilizado é a bicicleta elétrica** representando **53,78%** das viagens, seguida da **bicicleta clássica** com **43,72%**.

- O **scooter elétrico é bem menos utilizado** que os outros dois tipos, correspondendo a apenas **2,5%** das viagens.

### Estações Mais Populares

- Em grande parte das viagens, **os campos de estação de início estão ausentes**, o que pode indicar uso fora das estações tradicionais, como nos casos de bicicletas/scooters elétricos com sistema dockless.

Esses insights permitem identificar padrões comportamentais de uso, tipo de transporte e sazonalidade, contribuindo para compreender o perfil dos usuários.