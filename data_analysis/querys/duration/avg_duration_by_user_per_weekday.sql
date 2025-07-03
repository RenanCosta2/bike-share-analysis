-- Recupera a duração média das viagens por tipo de ciclista nos dias da semana
SELECT 
  member_casual,
  day_of_week_name,
  TIME(TIMESTAMP_SECONDS(CAST(ROUND(AVG(ride_length_seconds)) AS INT64))) AS avg_ride_length,
  ROUND(AVG(ride_length_seconds)) AS avg_ride_length_seconds
FROM 
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  member_casual,
  day_of_week_name
ORDER BY
  member_casual,
  avg_ride_length_seconds DESC;
