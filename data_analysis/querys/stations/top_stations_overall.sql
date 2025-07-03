-- Recupera as estações mais populares
SELECT
  started_station_name, -- As estações com nome vazio indica que a viagem iniciou em um estação de ancoragem
  COUNT(ride_id) AS num_trips
FROM
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  started_station_name
ORDER BY
  num_trips DESC
LIMIT 5;
