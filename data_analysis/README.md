# An??lises SQL no Big Query

Este arquivo cont??m as consultas SQL utilizadas para a an??lise do estudo de caso, executadas diretamente no Google BigQuery. O objetivo dessa an??lise ?? identificar os padr??es de uso das bicicletas entre ciclistas casuais e membros anuais.

## Consultas Dispon??veis

As consultas abaixo foram estruturadas a fim de realizar uma an??lise explorat??ria e estat??stica dos dados, organizadas nas seguintes vertentes principais:

-   Dura????o das viagens
-   Quantidade de viagens
-   Padr??es temporais
-   Esta????es

### Dura????o de Viagens

-   [`avg_max_duration.sql`](querys/duration/avg_max_duration.sql) - Retorna a dura????o m??dia e a m??xima das viagens.

-   [`avg_duration_by_user.sql`](querys/duration/avg_duration_by_user.sql) - Retorna a dura????o m??dia das viagens por tipo de ciclista.

-   [`avg_duration_by_rideable_type.sql`](querys/duration/avg_duration_by_rideable_type.sql) - Retorna a dura????o m??dia das viagens por tipo de transporte.

-   [`avg_duration_by_user_per_month.sql`](querys/duration/avg_duration_by_user_per_month.sql) - Retorna a dura????o m??dia das viagens por tipo de ciclista em cada m??s.

-   [`avg_duration_by_user_per_weekday.sql`](querys/duration/avg_duration_by_user_per_weekday.sql) - Retorna a dura????o m??dia das viagens por tipo de ciclista nos dias da semana.

### Quantidade de Viagens

-   [`trips_per_weekday.sql`](querys/trip_counts/trips_per_weekday.sql) - Retorna o n??mero de viagens por dias da semana.

-   [`trips_by_user_per_weekday.sql`](querys/trip_counts/trips_by_user_per_weekday.sql) - Retorna o n??mero de viagens por dia da semana para cada tipo de ciclista.

-   [`trips_by_user_per_rideable_type.sql`](querys/trip_counts/trips_by_user_per_rideable_type.sql) - Retorna o n??mero de viagens por tipo de transporte para cada tipo de ciclista.

-   [`trips_by_user_per_month.sql`](querys/trip_counts/trips_by_user_per_month.sql) - Retorna o n??mero de viagens por tipo de ciclista em cada m??s.

### Padr??es Temporais

-   [`peak_hours_by_user.sql`](querys/time_patterns/peak_hours_by_user.sql) - Retorna os hor??rios de pico para cada tipo de ciclista.

### Esta????es

-   [`top_stations_overall.sql`](querys/stations/top_stations_overall.sql) - Retorna as esta????es mais populares.

-   [`top_stations_by_user.sql`](querys/stations/top_stations_by_user.sql) - Retorna as esta????es mais populares para cada tipo de ciclista.

Os resultados para cada uma dessas consultas foram separados e organizados em formato `JSON` na pasta de [outputs](outputs).

## Resumo das An??lises

Durante o per??odo analisado (junho/2024 a maio/2025), foram processadas e analisadas mais de 5 milh??es de viagens realizadas com bicicletas compartilhadas da Divvy. Abaixo est??o os principais insights obtidos:

### Padr??es Temporais

- Ambos os usu??rios tendem a utilizar o servi??o com maior frequ??ncia entre os meses de **junho e outubro**.

- Nos meses entre **dezembro e fevereiro**, a **quantidade de viagens realizadas decai** consideravelmente.

- Os **casuais** tendem a utilizar o servi??o com **maior frequ??ncia no per??odo da tarde**, entre 14 e 18 horas. 
Os **membros** t??m um comportamento similar, por??m tamb??m realizam um volume significativo de viagens no **in??cio da manh??**, ??s 8:00.

### Dura????o das Viagens

-   A dura????o m??dia foi de **14:30 minutos**, que s??o viagens relativamente curtas, indicando que utilizam o servi??o para percorrer pequenas dist??ncias. No entanto, a **dura????o m??xima** observada foi pr??xima ao limite imposto na etapa de limpeza dos dados, de aproximadamente **4 horas**.

- A **dura????o m??dia mensal das viagens** tem um comportamento similar aos padr??es temporais identificados na frequ??ncia de viagens mensais.

- Viagens com **bicicletas cl??ssicas** tendem a ser mais longas do que com **bicicletas el??tricas/scooters**.

- As viagens de maior dura????o acontecem nas **sextas-feiras e nos fins de semana**.

### Perfil de Uso por Usu??rio

- A dura????o m??dia de viagem dos **ciclistas casuais (~ 19 minutos)** ?? relativamente maior que dos **membros (~ 12 minutos)**.

- Os **casuais** usam predominantemente o servi??o aos **fins de semana**, indicando um perfil recreativo.

- Os **membros** apresentam o comportamento oposto, no qual a **predomin??ncia do uso s??o nos dias ??teis** e os **dias com menos viagens s??o nos finais de semana**, apontando um uso do servi??o como meio de transporte.

### Tipo de Transporte Utilizado

- O tipo de transporte **mais utilizado ?? a bicicleta el??trica** representando **53,78%** das viagens, seguida da **bicicleta cl??ssica** com **43,72%**.

- O **scooter el??trico ?? bem menos utilizado** que os outros dois tipos, correspondendo a apenas **2,5%** das viagens.

### Esta????es Mais Populares

- Em grande parte das viagens, **os campos de esta????o de in??cio est??o ausentes** ??? o que pode indicar uso fora das esta????es tradicionais, como nos casos de bicicletas/scooters el??tricos com sistema dockless.

Esses insights permitem identificar padr??es comportamentais de uso, tipo de transporte e sazonalidade, contribuindo para compreender o perfil dos usu??rios.