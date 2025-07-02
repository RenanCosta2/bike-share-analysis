# Changelog

Este arquivo contém as mudanças nos dados do projeto.

Versão 1.0.0 (26/06/2025)

## New

-   Como todos os datasets possuem a mesma estrutura e representam apenas meses diferentes, foram combinados em um único dataset consolidado.

-   Para possibilitar operações com data e hora, o tipo das colunas `started_at` e `ended_at`, que inicialmente estavam definidas como strings (`character`), foi alterado para objetos do tipo `POSIXct`, que representam o tipo de data e hora.

-   Identifiquei dados ausentes nas colunas `end_lat` e `end_lng`, com **6166** registros faltantes em cada coluna. Como essas observações não possuem informações de término, esses registros foram removidas do dataset por inviabilizarem análises espaciais com precisão.

-   Identifiquei 171 registros com valores inconsistentes (strings vazias) na coluna `end_station_name` associados ao tipo de bicicleta `classic_bike`. Como esse tipo de bicicleta só pode ser atracada em estações da Divvy, esses registros são inconsistentes com o modelo operacional da empresa. Portanto, elas foram removidas do dataset por não serem confiáveis para análise.

-   Identifiquei inconsistências na formatação das colunas `start_station_name` e `end_station_name`, com a presença de caracteres extras como "\*" e sufixos como "(Temp)", o que impede operações de agrupamento. Para garantir a uniformidade das colunas essas inconsistências foram removidas.

-   Visando obter a informação da duração das viagens de forma mais clara e estruturada, adicionei a coluna `ride_length` para armazenar o cálculo da diferença de tempo entre o fim (`ended_at`) e o início da viagem (`start_at`) no formato `HH:MM:SS`. A coluna `ride_length_seconds` também foi adicionada como apoio numérico, visto que armazena o valor em segundos.

-   Adicionei a coluna `day_of_week` para indicar qual o dia da semana que iniciou a viagem, essa coluna armazena os dias de forma numerada do **1 = Domingo** até o **7 = Sábado**. Foi adicionado também a coluna `day_of_week_name` com o nome da semana por extenso, para facilitar a visualização e a compreensão da informação.

------------------------------------------------------------------------

Versão 1.1.0 (27/06/2025)

## New

-   Para manter a integridade dos dados, registros com duração de viagem inferior a 60 segundos, que possivelmente indicam falsos inícios ou tentativas de reencaixe da bicicleta na estação, foram removidos.

-   Por se trataram de viagens com bicicletas, é esperado que as viagens não possuam durações muito elevadas. Por conta disso, e tendo como base a política do diário da Divvy, em que o usuário pode utilizar uma mesma bicicleta por no máximo 3 horas (caso ultrapasse esse limite é cobrado taxas de tempo extra), foi adotado um limite de 4 horas como critério superior de corte. Dessa forma, todas as viagens com duração superior a 4 horas foram removidas do dataset.
