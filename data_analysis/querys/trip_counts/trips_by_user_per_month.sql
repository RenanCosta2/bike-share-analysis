-- Recupera o número de viagens por tipo de ciclista em cada mês 
SELECT 
  EXTRACT(YEAR FROM ended_at) year,
  EXTRACT(MONTH FROM ended_at) month,
  member_casual,
  COUNT(ride_id) AS num_trips
FROM 
  `ornate-shine-402117.bike_share_analysis.trip_data`
GROUP BY
  member_casual,
  year,
  month
ORDER BY
  member_casual,
  num_trips DESC;