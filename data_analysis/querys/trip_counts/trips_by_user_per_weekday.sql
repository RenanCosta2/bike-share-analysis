-- Recupera o número de viagens por dia da semana para cada tipo de ciclista
SELECT
  member_casual,
  day_of_week_name,
  COUNT(ride_id) AS num_trips
FROM
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  member_casual,
  day_of_week_name
ORDER BY
  member_casual,
  num_trips DESC;