-- Recupera o número de viagens por tipo de transporte para cada tipo de ciclista
SELECT
  member_casual,
  rideable_type,
  COUNT(ride_id) AS num_trips,
  ROUND(COUNT(ride_id) / (
    SELECT
      COUNT(ride_id) AS total_trips
    FROM
      `ornate-shine-402117.bike_share_analysis.trip_data`
  ) * 100, 2) AS trips_percentage
FROM
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  member_casual,
  rideable_type
ORDER BY
  member_casual,
  num_trips DESC;