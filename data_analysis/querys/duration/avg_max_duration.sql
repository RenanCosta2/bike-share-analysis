-- Recupera a duração média e a máxima das viagens
SELECT 
  TIME(TIMESTAMP_SECONDS(CAST(ROUND(AVG(ride_length_seconds)) AS INT64))) AS avg_ride_length,
  ROUND(AVG(ride_length_seconds)) AS avg_ride_length_seconds,
  TIME(TIMESTAMP_SECONDS(CAST(ROUND(MAX(ride_length_seconds)) AS INT64))) AS max_ride_length,
  ROUND(MAX(ride_length_seconds)) AS max_ride_length_seconds
FROM 
  `ornate-shine-402117.bike_share_analysis.trip_data`;
