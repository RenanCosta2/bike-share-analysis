-- Recupera as estações mais populares para cada tipo de ciclista
WITH ranked_stations AS (
  SELECT
    member_casual,
    started_station_name, -- As estações com nome vazio indica que a viagem iniciou em um estação de ancoragem
    COUNT(ride_id) AS num_trips,
    ROW_NUMBER() OVER(PARTITION BY member_casual ORDER BY COUNT(ride_id) DESC) AS rank_station
  FROM
    `ornate-shine-402117.bike_share_analysis.trip_data`
  GROUP BY
    member_casual,
    started_station_name
)

SELECT
  *
FROM
  ranked_stations
WHERE
  rank_station <= 5
ORDER BY
  member_casual,
  num_trips DESC;