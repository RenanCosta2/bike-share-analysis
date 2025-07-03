-- Recupera o número de viagens por dia da semana
SELECT
  day_of_week_name,
  COUNT(ride_id) AS num_trips
FROM
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  day_of_week_name
ORDER BY
  num_trips DESC;