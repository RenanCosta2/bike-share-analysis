data_cleaning
================
Renan Costa
2025-06-27

# Pré-processamento

Este documento assume que o pacote `tidyverse` já está instalado no
ambiente. Caso contrário, instale-o antes de executar os chunks abaixo.

``` r
# Carregando os pacotes
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.4     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

## Import dos dados

Cada um dos datasets utilizados nesse projeto corresponde a um dos meses
mais recentes disponíveis até o momento, abrangendo o período de junho
de 2024 a maio de 2025. Como esses datasets possuem a mesma estrutura,
representando apenas meses diferentes, é mais eficiente juntá-los em um
único dataset para facilitar o processamento e a análise.

``` r
# Lista todos os arquivos .csv na pasta
arquivos_csv <- list.files(path = "../data_raw/", pattern = "*.csv", full.names = TRUE)

# Lê e empilha todos os arquivos em um único dataframe
trip_data <- arquivos_csv %>% 
  map_dfr(read.csv)
```

## Exploração dos Dados

Antes de iniciar a limpeza do dataset é fundamental inspecionar a
estrutura e os tipos de dados do dataset para identificar possíveis
inconsistências. Para isso será utilizado a função `glimpse()` para
obter uma visão geral do dataset e, se necessário, realizar alguma
transformação.

``` r
# Visão geral do dataframe
glimpse(trip_data)
```

    ## Rows: 5,628,847
    ## Columns: 13
    ## $ ride_id            <chr> "CDE6023BE6B11D2F", "462B48CD292B6A18", "9CFB6A858D…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <chr> "2024-06-11 17:20:06.289", "2024-06-11 17:19:21.567…
    ## $ ended_at           <chr> "2024-06-11 17:21:39.464", "2024-06-11 17:19:36.377…
    ## $ start_station_name <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ start_station_id   <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ end_station_name   <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ end_station_id     <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ start_lat          <dbl> 41.89, 41.89, 41.93, 41.88, 41.94, 41.94, 41.94, 41…
    ## $ start_lng          <dbl> -87.65, -87.65, -87.65, -87.64, -87.64, -87.64, -87…
    ## $ end_lat            <dbl> 41.89000, 41.89000, 41.94000, 41.88000, 41.94000, 4…
    ## $ end_lng            <dbl> -87.65000, -87.65000, -87.65000, -87.64000, -87.640…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

A partir da visão geral obtida anteriormente, foi identificado uma
inconsistência na tipagem das colunas `started_at` e `ended_at`. Embora
representem data e hora, ambas estão definidas como strings
(`character`), o que inviabiliza operações temporais adequadas.

``` r
# Corrigindo o tipo das colunas para representar datas
trip_data$started_at <- as.POSIXct(trip_data$started_at, format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")
trip_data$ended_at <- as.POSIXct(trip_data$ended_at, format = "%Y-%m-%d %H:%M:%OS", tz = "UTC")
```

``` r
# Visão geral do dataframe
glimpse(trip_data)
```

    ## Rows: 5,628,847
    ## Columns: 13
    ## $ ride_id            <chr> "CDE6023BE6B11D2F", "462B48CD292B6A18", "9CFB6A858D…
    ## $ rideable_type      <chr> "electric_bike", "electric_bike", "electric_bike", …
    ## $ started_at         <dttm> 2024-06-11 17:20:06, 2024-06-11 17:19:21, 2024-06-…
    ## $ ended_at           <dttm> 2024-06-11 17:21:39, 2024-06-11 17:19:36, 2024-06-…
    ## $ start_station_name <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ start_station_id   <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ end_station_name   <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ end_station_id     <chr> "", "", "", "", "", "", "", "", "", "", "", "", "",…
    ## $ start_lat          <dbl> 41.89, 41.89, 41.93, 41.88, 41.94, 41.94, 41.94, 41…
    ## $ start_lng          <dbl> -87.65, -87.65, -87.65, -87.64, -87.64, -87.64, -87…
    ## $ end_lat            <dbl> 41.89000, 41.89000, 41.94000, 41.88000, 41.94000, 4…
    ## $ end_lng            <dbl> -87.65000, -87.65000, -87.65000, -87.64000, -87.640…
    ## $ member_casual      <chr> "casual", "casual", "casual", "casual", "casual", "…

Como é possível observar na visão geral do dataset acima, as colunas
`started_at` e `ended_at` foram convertidas corretamente de `<chr>` para
objetos do tipo `POSIXct`, sendo exibidas como `<dttm>` pela função
`glimpse()`. Isso confirma que essas variáveis agora estão aptas para
operações com data e hora.

# Limpeza dos Dados

Com a estrutura do dataset ajustada e os tipos de dados devidamente
corrigidos, inicia-se agora a etapa de limpeza dos dados.

## Intervalo de Datas

Como mencionado anteriormente, os datasets utilizados nesse projeto
abrangem o período de junho de 2024 a maio de 2025, portanto, é
importante verificar se as colunas de datas estão nesse período.

``` r
# Verificando o período das datas
trip_data %>% 
  filter(!between(as.Date(started_at), as.Date("2024-06-01"), as.Date("2025-05-31")) |
           !between(as.Date(ended_at), as.Date("2024-06-01"), as.Date("2025-05-31"))) %>% 
  select(started_at, ended_at)
```

    ##              started_at            ended_at
    ## 1   2024-05-31 23:50:04 2024-06-01 00:06:08
    ## 2   2024-05-31 23:51:07 2024-06-01 00:25:37
    ## 3   2024-05-31 23:56:12 2024-06-01 00:10:02
    ## 4   2024-05-31 11:50:26 2024-06-01 09:52:57
    ## 5   2024-05-31 23:53:26 2024-06-01 00:04:05
    ## 6   2024-05-31 23:56:39 2024-06-01 00:06:59
    ## 7   2024-05-31 23:09:06 2024-06-01 08:47:44
    ## 8   2024-05-31 23:46:19 2024-06-01 00:14:05
    ## 9   2024-05-31 23:41:48 2024-06-01 00:06:02
    ## 10  2024-05-31 22:54:20 2024-06-01 00:42:41
    ## 11  2024-05-31 23:56:54 2024-06-01 00:05:11
    ## 12  2024-05-31 23:48:51 2024-06-01 00:08:37
    ## 13  2024-05-31 21:06:26 2024-06-01 02:36:52
    ## 14  2024-05-31 23:44:02 2024-06-01 00:13:12
    ## 15  2024-05-31 23:49:19 2024-06-01 00:06:01
    ## 16  2024-05-31 23:52:30 2024-06-01 00:00:02
    ## 17  2024-05-31 23:54:16 2024-06-01 00:16:08
    ## 18  2024-05-31 11:49:34 2024-06-01 00:05:55
    ## 19  2024-05-31 23:56:44 2024-06-01 00:04:13
    ## 20  2024-05-31 19:02:10 2024-06-01 01:07:01
    ## 21  2024-05-31 23:21:43 2024-06-01 00:04:18
    ## 22  2024-05-31 23:57:58 2024-06-01 00:17:09
    ## 23  2024-05-31 23:50:36 2024-06-01 00:16:42
    ## 24  2024-05-31 23:57:59 2024-06-01 00:16:56
    ## 25  2024-05-31 20:56:46 2024-06-01 17:56:00
    ## 26  2024-05-31 23:55:09 2024-06-01 00:00:26
    ## 27  2024-05-31 23:18:54 2024-06-01 00:10:55
    ## 28  2024-05-31 23:18:37 2024-06-01 00:11:00
    ## 29  2024-05-31 23:21:09 2024-06-01 00:32:20
    ## 30  2024-05-31 23:54:35 2024-06-01 00:01:25
    ## 31  2024-05-31 23:58:04 2024-06-01 00:04:35
    ## 32  2024-05-31 23:57:54 2024-06-01 00:00:20
    ## 33  2024-05-31 23:57:27 2024-06-01 00:19:54
    ## 34  2024-05-31 23:50:58 2024-06-01 00:06:25
    ## 35  2024-05-31 23:44:11 2024-06-01 00:00:28
    ## 36  2024-05-31 18:23:08 2024-06-01 00:53:50
    ## 37  2024-05-31 23:55:44 2024-06-01 00:07:11
    ## 38  2024-05-31 23:54:18 2024-06-01 00:00:58
    ## 39  2024-05-31 20:10:57 2024-06-01 09:21:21
    ## 40  2024-05-31 23:41:00 2024-06-01 00:01:21
    ## 41  2024-05-31 17:36:43 2024-06-01 00:12:29
    ## 42  2024-05-31 22:28:32 2024-06-01 00:50:53
    ## 43  2024-05-31 22:42:32 2024-06-01 00:51:09
    ## 44  2024-05-31 23:38:32 2024-06-01 00:19:09
    ## 45  2024-05-31 23:38:36 2024-06-01 00:19:11
    ## 46  2024-05-31 23:58:52 2024-06-01 00:19:50
    ## 47  2024-05-31 23:34:14 2024-06-01 00:22:46
    ## 48  2024-05-31 23:56:47 2024-06-01 00:29:35
    ## 49  2024-05-31 23:53:31 2024-06-01 00:04:30
    ## 50  2024-05-31 23:58:09 2024-06-01 00:00:24
    ## 51  2024-05-31 23:39:06 2024-06-01 00:08:42
    ## 52  2024-05-31 23:59:37 2024-06-01 00:06:39
    ## 53  2024-05-31 23:56:51 2024-06-01 00:06:43
    ## 54  2024-05-31 23:38:38 2024-06-01 00:08:45
    ## 55  2024-05-31 23:36:38 2024-06-01 01:29:28
    ## 56  2024-05-31 20:09:42 2024-06-01 17:13:53
    ## 57  2024-05-31 23:56:03 2024-06-01 00:09:26
    ## 58  2024-05-31 23:56:07 2024-06-01 00:10:44
    ## 59  2024-05-31 23:47:31 2024-06-01 00:06:43
    ## 60  2024-05-31 23:06:03 2024-06-01 09:46:16
    ## 61  2024-05-31 23:51:53 2024-06-01 00:10:32
    ## 62  2024-05-31 23:54:59 2024-06-01 00:01:47
    ## 63  2024-05-31 23:45:51 2024-06-01 00:11:46
    ## 64  2024-05-31 23:47:05 2024-06-01 00:04:57
    ## 65  2024-05-31 23:47:02 2024-06-01 00:07:18
    ## 66  2024-05-31 23:49:06 2024-06-01 00:12:02
    ## 67  2024-05-31 23:49:16 2024-06-01 00:10:09
    ## 68  2024-05-31 23:50:53 2024-06-01 00:15:12
    ## 69  2024-05-31 23:51:02 2024-06-01 00:14:37
    ## 70  2024-05-31 23:19:48 2024-06-01 00:14:33
    ## 71  2024-05-31 23:17:35 2024-06-01 00:14:45
    ## 72  2024-05-31 23:06:30 2024-06-01 00:14:58
    ## 73  2024-05-31 16:42:24 2024-06-01 13:13:42
    ## 74  2024-05-31 23:48:34 2024-06-01 00:11:45
    ## 75  2024-05-31 23:22:30 2024-06-01 00:07:33
    ## 76  2024-05-31 23:21:43 2024-06-01 00:07:39
    ## 77  2024-05-31 23:35:06 2024-06-01 00:09:03
    ## 78  2024-05-31 23:11:00 2024-06-01 00:14:31
    ## 79  2024-05-31 22:52:38 2024-06-01 00:14:08
    ## 80  2024-05-31 23:56:30 2024-06-01 00:09:42
    ## 81  2024-05-31 23:57:11 2024-06-01 00:04:49
    ## 82  2024-05-31 23:49:00 2024-06-01 00:04:00
    ## 83  2024-05-31 23:55:16 2024-06-01 00:02:30
    ## 84  2024-05-31 23:55:23 2024-06-01 00:02:30
    ## 85  2024-05-31 23:45:42 2024-06-01 00:01:28
    ## 86  2024-05-31 23:32:23 2024-06-01 00:14:04
    ## 87  2024-05-31 23:18:10 2024-06-01 00:13:21
    ## 88  2024-05-31 23:56:10 2024-06-01 00:00:02
    ## 89  2024-05-31 23:51:57 2024-06-01 00:02:15
    ## 90  2024-05-31 23:52:19 2024-06-01 00:02:17
    ## 91  2024-05-31 16:34:46 2024-06-01 04:12:45
    ## 92  2024-05-31 23:40:08 2024-06-01 00:01:06
    ## 93  2024-05-31 23:40:05 2024-06-01 00:01:51
    ## 94  2024-05-31 23:40:36 2024-06-01 00:00:29
    ## 95  2024-05-31 23:51:54 2024-06-01 00:07:17
    ## 96  2024-05-31 23:53:04 2024-06-01 00:13:17
    ## 97  2024-05-31 22:59:38 2024-06-01 00:02:24
    ## 98  2024-05-31 23:31:03 2024-06-01 00:00:03
    ## 99  2024-05-31 23:57:00 2024-06-02 00:56:55
    ## 100 2024-05-31 18:12:14 2024-06-01 19:11:54
    ## 101 2024-05-31 23:55:36 2024-06-01 00:09:19
    ## 102 2024-05-31 23:58:38 2024-06-01 00:06:09
    ## 103 2024-05-31 18:21:43 2024-06-01 19:21:21
    ## 104 2024-05-31 23:59:57 2024-06-01 00:11:38
    ## 105 2024-05-31 16:06:45 2024-06-01 17:06:34
    ## 106 2024-05-31 17:46:08 2024-06-01 18:45:46
    ## 107 2024-05-31 18:44:12 2024-06-01 19:43:51
    ## 108 2024-05-31 11:03:57 2024-06-01 12:03:51
    ## 109 2024-05-31 06:32:22 2024-06-01 07:32:01
    ## 110 2024-05-31 14:50:40 2024-06-01 15:50:31
    ## 111 2024-05-31 23:59:56 2024-06-01 00:43:58
    ## 112 2024-05-31 19:52:00 2024-06-01 20:51:55
    ## 113 2024-05-31 11:30:35 2024-06-01 12:30:30
    ## 114 2024-05-31 23:47:51 2024-06-01 00:02:53
    ## 115 2024-05-31 15:21:08 2024-06-01 16:21:01
    ## 116 2024-05-31 22:57:44 2024-06-01 23:57:27
    ## 117 2024-05-31 17:55:01 2024-06-01 18:54:53
    ## 118 2024-05-31 16:26:26 2024-06-01 17:26:05
    ## 119 2024-05-31 11:17:13 2024-06-01 12:17:05
    ## 120 2024-05-31 23:47:32 2024-06-01 00:11:02
    ## 121 2024-05-31 17:23:25 2024-06-01 18:23:17
    ## 122 2024-05-31 19:46:21 2024-06-01 20:46:16
    ## 123 2024-05-31 19:45:38 2024-06-01 20:45:33
    ## 124 2024-05-31 23:43:04 2024-06-01 00:04:24
    ## 125 2024-05-31 19:26:59 2024-06-01 20:26:55
    ## 126 2024-05-31 17:28:54 2024-06-01 18:28:46
    ## 127 2024-05-31 23:55:26 2024-06-01 00:06:26
    ## 128 2024-05-31 23:50:48 2024-06-01 00:04:35
    ## 129 2024-05-31 22:54:06 2024-06-01 00:07:50
    ## 130 2024-05-31 22:53:05 2024-06-01 00:49:47
    ## 131 2024-05-31 20:24:00 2024-06-01 21:23:38
    ## 132 2024-05-31 20:17:26 2024-06-01 21:17:21
    ## 133 2024-05-31 23:04:44 2024-06-02 00:04:41
    ## 134 2024-05-31 23:57:02 2024-06-01 00:07:18
    ## 135 2024-05-31 16:48:14 2024-06-01 17:48:08
    ## 136 2024-05-31 20:59:29 2024-06-01 21:59:22
    ## 137 2024-05-31 22:34:45 2024-06-01 23:34:40
    ## 138 2024-05-31 23:44:50 2024-06-01 00:23:13
    ## 139 2024-05-31 23:33:28 2024-06-01 00:05:09
    ## 140 2024-05-31 23:48:23 2024-06-01 00:10:27
    ## 141 2024-05-31 19:39:31 2024-06-01 10:27:17
    ## 142 2024-05-31 23:38:47 2024-06-01 00:17:54
    ## 143 2024-05-31 23:32:20 2024-06-01 00:50:10
    ## 144 2024-05-31 23:55:59 2024-06-01 00:06:52
    ## 145 2024-05-31 23:48:34 2024-06-01 00:30:04
    ## 146 2024-05-31 23:50:55 2024-06-01 00:29:56
    ## 147 2024-05-31 23:17:35 2024-06-01 00:15:41
    ## 148 2024-05-31 23:53:55 2024-06-01 00:30:18
    ## 149 2024-05-31 23:51:45 2024-06-01 00:02:32
    ## 150 2024-05-31 22:50:23 2024-06-01 00:14:32
    ## 151 2024-05-31 23:51:39 2024-06-01 00:22:09
    ## 152 2024-05-31 23:59:47 2024-06-01 00:20:16
    ## 153 2024-05-31 23:41:03 2024-06-01 00:50:17
    ## 154 2024-05-31 23:57:51 2024-06-01 00:05:28
    ## 155 2024-05-31 23:55:12 2024-06-01 00:11:55
    ## 156 2024-05-31 23:42:42 2024-06-01 00:25:08
    ## 157 2024-05-31 23:38:11 2024-06-01 00:23:17
    ## 158 2024-05-31 23:45:47 2024-06-01 00:23:48
    ## 159 2024-05-31 23:51:12 2024-06-01 00:01:17
    ## 160 2024-05-31 18:18:02 2024-06-01 07:27:41
    ## 161 2024-05-31 22:49:28 2024-06-01 04:55:05
    ## 162 2024-05-31 23:50:19 2024-06-01 00:13:45
    ## 163 2024-05-31 23:20:35 2024-06-01 00:33:41
    ## 164 2024-05-31 23:20:23 2024-06-01 00:33:19
    ## 165 2024-05-31 23:52:07 2024-06-01 00:05:59
    ## 166 2024-05-31 23:33:06 2024-06-01 00:05:00
    ## 167 2024-05-31 23:45:06 2024-06-01 00:08:38
    ## 168 2024-05-31 18:04:57 2024-06-01 00:51:24
    ## 169 2024-05-31 23:43:04 2024-06-01 00:02:46
    ## 170 2024-05-31 22:42:51 2024-06-01 00:51:19
    ## 171 2024-05-31 23:45:59 2024-06-01 00:11:51
    ## 172 2024-05-31 23:48:38 2024-06-01 00:13:31
    ## 173 2024-05-31 20:27:14 2024-06-01 13:28:51
    ## 174 2024-05-31 22:35:31 2024-06-01 09:05:13
    ## 175 2024-05-31 23:48:30 2024-06-01 00:13:35
    ## 176 2024-05-31 23:54:51 2024-06-01 00:01:43
    ## 177 2024-05-31 11:06:59 2024-06-01 12:06:55
    ## 178 2024-05-31 19:20:23 2024-06-01 20:20:04
    ## 179 2024-05-31 19:19:38 2024-06-01 20:19:29
    ## 180 2024-05-31 23:56:20 2024-06-01 00:02:50
    ## 181 2024-05-31 23:54:07 2024-06-01 00:05:04
    ## 182 2024-05-31 23:38:44 2024-06-01 00:33:46
    ## 183 2024-05-31 20:08:50 2024-06-01 21:08:43
    ## 184 2024-05-31 07:16:24 2024-06-01 08:16:16
    ## 185 2024-05-31 15:11:01 2024-06-01 16:10:55
    ## 186 2024-05-31 22:26:40 2024-06-01 00:36:20
    ## 187 2024-05-31 22:16:23 2024-06-01 00:36:54
    ## 188 2024-05-31 01:02:49 2024-06-01 02:02:43
    ## 189 2024-05-31 16:49:50 2024-06-01 17:49:43
    ## 190 2024-05-31 23:58:00 2024-06-01 00:16:18
    ## 191 2024-05-31 09:27:11 2024-06-01 10:26:48
    ## 192 2024-05-31 23:40:50 2024-06-01 00:06:38
    ## 193 2024-05-31 21:12:46 2024-06-01 22:12:41
    ## 194 2024-05-31 16:01:32 2024-06-01 17:01:28
    ## 195 2024-05-31 16:01:20 2024-06-01 17:01:15
    ## 196 2024-05-31 23:38:58 2024-06-01 00:19:37
    ## 197 2024-05-31 17:59:55 2024-06-01 18:59:32
    ## 198 2024-05-31 18:17:30 2024-06-01 19:17:23
    ## 199 2024-05-31 23:45:20 2024-06-01 00:34:32
    ## 200 2024-05-31 23:52:02 2024-06-01 00:07:35
    ## 201 2024-05-31 23:44:19 2024-06-01 00:04:09
    ## 202 2024-05-31 23:53:44 2024-06-01 00:12:26
    ## 203 2024-05-31 23:34:36 2024-06-01 00:14:29
    ## 204 2024-05-31 23:58:50 2024-06-01 00:11:02
    ## 205 2024-05-31 23:57:09 2024-06-01 00:18:09
    ## 206 2024-05-31 23:54:52 2024-06-01 00:07:51
    ## 207 2024-05-31 01:09:43 2024-06-01 02:09:36
    ## 208 2024-05-31 23:57:45 2024-06-01 00:13:39
    ## 209 2024-05-31 23:34:26 2024-06-01 00:11:15
    ## 210 2024-05-31 18:01:22 2024-06-01 19:01:14
    ## 211 2024-05-31 23:31:22 2024-06-01 00:01:09

A verificação acima demonstra que 211 viagens **iniciaram em 31 de maio
de 2024**, indicando que está fora do período determinado. Porém, todas
essas viagens **encerraram em 1º de junho de 2024**, que está dentro do
intervalo válido, justificando a permanência dessas viagens no dataset.

``` r
# Verificando a quantidade de viagens que iniciaram e encerraram fora do período determinado
trip_data %>% 
  filter(!between(as.Date(started_at), as.Date("2024-06-01"), as.Date("2025-05-31")) &
           !between(as.Date(ended_at), as.Date("2024-06-01"), as.Date("2025-05-31"))) %>% 
  count()
```

    ##   n
    ## 1 0

## Dados Ausentes

``` r
# Conta a quantidade de dados ausentes em cada coluna
trip_data %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>% 
  pivot_longer(cols = everything(), names_to = "variable", values_to = "na_count") %>%
  arrange(desc(na_count))
```

    ## # A tibble: 13 × 2
    ##    variable           na_count
    ##    <chr>                 <int>
    ##  1 end_lat                6166
    ##  2 end_lng                6166
    ##  3 ride_id                   0
    ##  4 rideable_type             0
    ##  5 started_at                0
    ##  6 ended_at                  0
    ##  7 start_station_name        0
    ##  8 start_station_id          0
    ##  9 end_station_name          0
    ## 10 end_station_id            0
    ## 11 start_lat                 0
    ## 12 start_lng                 0
    ## 13 member_casual             0

A análise acima identificou **12.332** registros faltantes no dataset,
onde **6.166** registros não possuem valor nas colunas `end_lat` e
`end_lng`.

``` r
# Identifica o tipo de bicicleta utilizada nos registros com dados ausentes
trip_data %>% 
  filter(is.na(end_lat) | is.na(end_lng)) %>% 
  count(rideable_type)
```

    ##   rideable_type    n
    ## 1  classic_bike 6166

Ao investigar mais a fundo, foi identificado que todos os registros de
dados ausentes ocorreram com bicicletas do tipo `classic_bike`. Como
essas observações não possuem informações de término, esses registros
serão removidas do dataset por inviabilizarem análises espaciais com
precisão.

``` r
# Removendo dados ausentes das colunas end_lat e end_lng
trip_data_clean <- trip_data %>% 
  drop_na()

# Conta a quantidade de dados ausentes no dataset
sum(is.na(trip_data_clean))
```

    ## [1] 0

Além dos dados ausentes analisados anteriormente, é necessário verificar
campos que possuem valores inconsistentes, como strings vazias (`""`),
que também representam campos incompletos em variáveis do tipo texto.

``` r
# Conta a quantidade de valores com strings vazias em cada coluna
trip_data_clean %>%
  summarise(across(where(is.character), ~ sum(. == ""))) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "empty_count") %>%
  arrange(desc(empty_count))
```

    ## # A tibble: 7 × 2
    ##   variable           empty_count
    ##   <chr>                    <int>
    ## 1 end_station_name       1104574
    ## 2 end_station_id         1104574
    ## 3 start_station_name     1081945
    ## 4 start_station_id       1081945
    ## 5 ride_id                      0
    ## 6 rideable_type                0
    ## 7 member_casual                0

``` r
# Identifica o tipo de bicicleta utilizada nos registros com strings vazias
trip_data_clean %>% 
    filter(start_station_name == "" | end_station_name == "") %>% 
  count(rideable_type)
```

    ##      rideable_type       n
    ## 1     classic_bike     171
    ## 2    electric_bike 1566340
    ## 3 electric_scooter   96510

Ao observar os registros que possuem strings vazias, foi identificado
que a maioria das viagens estão associadas ao tipos de `electric_bike` e
`electric_scooter`. Esse padrão é consistente com o comportamento das
bicicletas e scooters eletrônicos da Divvy, que podem ser trancadas ou
liberadas em locais públicos habilitados (fora das estações
tradicionais).

Dessa forma, esses registros serão mantidos, pois refletem trajetos
válidos dentro do modelo operacional da Divvy.

No entanto, foram identificados 171 registros com strings vazias
associados ao tipo `classic_bike`. Como esse tipo de bicicleta só pode
ser atracada em estações da Divvy, esses registros são inconsistentes
com o modelo operacional da empresa. Portanto, elas serão removidas do
dataset por não serem confiáveis para análise.

``` r
# Removendo os registros com strings vazias associadas ao tipo de bicicleta "classic_bike"
trip_data_clean <- trip_data_clean %>% 
  filter(!
           (
             (start_station_name == "" | end_station_name == "") 
             & rideable_type == "classic_bike"
           )
         )

# Tipos de bicicletas com strings vazias
trip_data_clean %>% 
  filter(start_station_name == "" | end_station_name == "") %>% 
  count(rideable_type)
```

    ##      rideable_type       n
    ## 1    electric_bike 1566340
    ## 2 electric_scooter   96510

## Variáveis Categóricas

As colunas `rideable_type` e `member_casual` do dataset contêm variáveis
categóricas, ou seja, valores predefinidos para seus campos,
representando diferentes tipos de bicicletas e perfis de usuários,
respectivamente. As categorias de cada coluna são:

- `rideable_type`: `classic_bike`, `electric_bike`, `electric_scooter`.
- `member_casual`: `casual`, `member`.

``` r
# Verificando as categorias da coluna "rideable_type"
trip_data_clean %>% 
  count(rideable_type)
```

    ##      rideable_type       n
    ## 1     classic_bike 2406799
    ## 2    electric_bike 3071374
    ## 3 electric_scooter  144337

``` r
# Verificando as categorias da coluna "member_casual"
trip_data_clean %>% 
  count(member_casual)
```

    ##   member_casual       n
    ## 1        casual 2058888
    ## 2        member 3563622

A análise das variáveis categóricas indica que os valores estão de
acordo com as predefinições.

## Dados Duplicados

``` r
# Conta a quantidade de registros duplicados
sum(duplicated(trip_data_clean))
```

    ## [1] 0

``` r
# Verifica se há IDs de corrida duplicado
trip_data_clean %>% 
  count(ride_id) %>% 
  filter(n > 1)
```

    ## [1] ride_id n      
    ## <0 linhas> (ou row.names de comprimento 0)

A verificação de duplicatas indica que não há registros duplicados no
dataset, incluindo o identificador único de viagem (`ride_id`), que não
apresenta repetições.

## Formatação de Strings

Nas colunas `start_station_name` e `end_station_name` há inconsistências
na formatação do nome de algumas estações, com a presença de caracteres
extras como “\*” e sufixos como “(Temp)”, o que impede operações de
agrupamento.

Para garantir a uniformidade das colunas essas inconsistências serão
removidas.

``` r
# Eliminando os caracteres indesejados
trip_data_clean <- trip_data_clean %>%
  mutate(start_station_name = start_station_name %>% 
           str_replace_all("\\*", "") %>% 
           str_replace_all("(Temp)", "") %>% 
           str_trim(),
         
         end_station_name = end_station_name %>% 
           str_replace_all("\\*", "") %>% 
           str_replace_all("(Temp)", "") %>% 
           str_trim())
```

## Adição de Colunas

Para realizar a análise desse dataset algumas colunas serão adicionadas
para uma melhor estruturação das informações.

A duração das viagens é uma informação extremamente útil para o
desenvolvimento da análise desse projeto. Para obter essa informação, é
necessário subtrair o dia e horário do início da viagem (`started_at`)
pelo dia e horário do fim da viagem (`ended_at`).O resultado desse
cálculo será armazenado na coluna `ride_length`, que será adicionada no
dataset no formato “HH:MM:SS” para apresentação, e na coluna
`ride_length_seconds`, quem armazenará a duração em segundos para
cálculos.

``` r
# Adição da  coluna "ride_length" que armazena o resultado do cálculo da duração da viagem
trip_data_clean <- trip_data_clean %>% 
  mutate(ride_length_seconds = as.numeric(ended_at - started_at),
         ride_length = sprintf(
           "%02d:%02d:%02d",
           as.integer(ride_length_seconds %/% 3600),
           as.integer((ride_length_seconds %% 3600) %/% 60),
           as.integer(ride_length_seconds %% 60)
         ))
trip_data_clean %>% 
  select(started_at, ended_at, ride_length, ride_length_seconds) %>% 
  head(10)
```

    ##             started_at            ended_at ride_length ride_length_seconds
    ## 1  2024-06-11 17:20:06 2024-06-11 17:21:39    00:01:33              93.175
    ## 2  2024-06-11 17:19:21 2024-06-11 17:19:36    00:00:14              14.810
    ## 3  2024-06-11 17:25:27 2024-06-11 17:30:13    00:04:45             285.946
    ## 4  2024-06-11 11:53:50 2024-06-11 12:08:13    00:14:22             862.613
    ## 5  2024-06-11 00:11:08 2024-06-11 00:11:22    00:00:14              14.761
    ## 6  2024-06-11 00:12:38 2024-06-11 00:12:57    00:00:19              19.417
    ## 7  2024-06-11 00:14:00 2024-06-11 00:20:35    00:06:34             394.571
    ## 8  2024-06-11 18:22:23 2024-06-11 19:26:41    01:04:18            3858.261
    ## 9  2024-06-11 12:51:10 2024-06-11 12:51:28    00:00:17              17.944
    ## 10 2024-06-11 12:49:24 2024-06-11 12:49:45    00:00:21              21.310

Ter o conhecimento acerca do dia da semana que geralmente ocorrem o
início das viagens pode ser uma informação relevante para análises do
dataset. Essa informação será armazenada na coluna `day_of_week`, que
corresponderá ao dia da semana em formato numérico. Note que os dias
estão numerados do **1 = Domingo** até o **7 = Sábado**. A coluna
`day_of_week_name` também será adicionada, para facilitar a visualização
do dia da semana correspondente.

``` r
# Adição da coluna "day_of_week" para representar os dias da semana
trip_data_clean <- trip_data_clean %>% 
  mutate(day_of_week = as.POSIXlt(started_at)$wday + 1,
         day_of_week_name = weekdays(started_at))
trip_data_clean %>% 
  select(started_at, day_of_week, day_of_week_name) %>% 
  head(10)
```

    ##             started_at day_of_week day_of_week_name
    ## 1  2024-06-11 17:20:06           3      terça-feira
    ## 2  2024-06-11 17:19:21           3      terça-feira
    ## 3  2024-06-11 17:25:27           3      terça-feira
    ## 4  2024-06-11 11:53:50           3      terça-feira
    ## 5  2024-06-11 00:11:08           3      terça-feira
    ## 6  2024-06-11 00:12:38           3      terça-feira
    ## 7  2024-06-11 00:14:00           3      terça-feira
    ## 8  2024-06-11 18:22:23           3      terça-feira
    ## 9  2024-06-11 12:51:10           3      terça-feira
    ## 10 2024-06-11 12:49:24           3      terça-feira

## Duração das Viagens

De acordo com a Divvy, os dados já haviam sido processados para remover
viagens com duração inferior a 60 segundos, alegando possíveis falsos
inícios ou tentativas de reencaixe da bicicleta na estação. Após a
criação das colunas `ride_length` e `ride_length_seconds`, essa
informação pode ser verificada facilmente.

``` r
# Conta a quantidade de viagens com duração inferior a 60 segundos
trip_data_clean %>% 
  select(started_at, ended_at, ride_length, ride_length_seconds) %>% 
  filter(ride_length_seconds < 60) %>% 
  summarise(trips = n())
```

    ##    trips
    ## 1 123248

A análise acima indica que há **123.248 viagens** com duração inferior a
60 segundos no dataset. Para manter a consistência dos dados, esses
registros serão removidos.

``` r
# Removendo os registros com as viagens inconsistentes
trip_data_clean <- trip_data_clean %>% 
  filter(ride_length_seconds > 60)

# Verificando a remoção dos registros
trip_data_clean %>% 
  select(started_at, ended_at, ride_length, ride_length_seconds) %>% 
  filter(ride_length_seconds < 60) %>% 
  summarise(trips = n())
```

    ##   trips
    ## 1     0

# Salvando o Dataset Tratado

``` r
# Cria a pasta "data_clean" caso não existir
if(!dir.exists("../data_cleaned")){
  dir.create("../data_cleaned")
}

# Salvo o dataset tratado dentro da pasta como arquivo CSV
write.csv(trip_data_clean, "../data_cleaned/trip_data_clean.csv", row.names = FALSE)
```
