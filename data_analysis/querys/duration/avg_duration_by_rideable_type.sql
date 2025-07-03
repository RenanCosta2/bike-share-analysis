-- Recupera a média da duração das viagens por tipo de transporte
SELECT 
  rideable_type,
  TIME(TIMESTAMP_SECONDS(CAST(ROUND(AVG(ride_length_seconds)) AS INT64))) AS avg_ride_length,
  ROUND(AVG(ride_length_seconds)) AS avg_ride_length_seconds
FROM 
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  rideable_type;