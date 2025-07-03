-- Recupera os horários de pico para cada tipo de ciclista
WITH ranked_trips AS (
  SELECT
    member_casual,
    EXTRACT(HOUR FROM started_at) AS hour,
    COUNT(ride_id) AS num_trips,
    ROW_NUMBER() OVER(PARTITION BY member_casual ORDER BY COUNT(ride_id) DESC) AS rank_trip
  FROM
    `ornate-shine-402117.bike_share_analysis.trip_data`
  GROUP BY
    member_casual,
    hour
)

SELECT
  *
FROM
  ranked_trips
WHERE
  rank_trip <= 5
ORDER BY
  member_casual,
  num_trips DESC;