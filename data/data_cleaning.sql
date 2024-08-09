--------------------------------------------------------------------------------------------

-- Change ##### with the name of your BigQuery project to reproduce the code

-- Schema of the new table that contains all data 
-- The name of the table is 'bike_rides'
CREATE TABLE `#####.bike_rides.bike_rides`
(
  ride_id STRING,
  rideable_type STRING,
  started_at TIMESTAMP,
  ended_at TIMESTAMP,
  start_station_name STRING,
  start_station_id STRING,
  end_station_name STRING,
  end_station_id STRING,
  start_lat FLOAT64,
  start_lng FLOAT64,
  end_lat FLOAT64,
  end_lng FLOAT64,
  member_casual STRING
)

-- Take a quick look at the data
SELECT
  *
FROM #####.bike_rides.bike_rides
LIMIT 10;
-- There are 5,734,381 rows in this table. 

-- Check string variables for duplicates, nulls or spelling errors
SELECT
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE ride_id IS NULL;

SELECT
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE rideable_type IS NULL;

SELECT
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE member_casual IS NULL;
-- Everything is fine

-- Chech time values for nulls
SELECT
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE (started_at IS NULL) OR (ended_at IS NULL);
-- No nulls found

-- Check if dates are inside bounds
SELECT 
  MIN(DATE(started_at)),
  MAX(DATE(started_at)),
  MIN(DATE(ended_at)),
  MAX(DATE(ended_at))
FROM #####.bike_rides.bike_rides;
-- Everything fine

-- Check station coordinates for nulls
SELECT
  *
FROM #####.bike_rides.bike_rides
WHERE (start_lat IS NULL) OR (start_lng IS NULL) OR (end_lat IS NULL)OR (end_lng IS NULL);
-- There are 7919 rows with nulls values. By further inspection, we see that the missing values come 
-- only from the end stations' coordinates

-- Chech the duration of these rides
SELECT
  member_casual,
  CASE 
    WHEN TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE) < 0 THEN 1440 + TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE)
    ELSE TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE)
  END AS ride_duration,
FROM #####.bike_rides.bike_rides
WHERE (end_lat IS NULL) OR (end_lng IS NULL) ;
-- the vast majority of these rides seem to last exactly 60 minutes, and many of them last an unexoected amount of time
-- This might be an indication of something going wrong with these rides, and it would be better to omit them
DELETE
FROM #####.bike_rides.bike_rides
WHERE (end_lat IS NULL) OR (end_lng IS NULL) ;

-- Check station names for nulls
SELECT 
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE (start_station_name IS NULL) OR (end_station_name IS NULL);
-- there are 1,452,114 rows with at least one null value in the station names

-- The same for station ids
SELECT 
  COUNT(*)
FROM #####.bike_rides.bike_rides
WHERE (start_station_id IS NULL) OR (end_station_id IS NULL);
-- again there are 1,452,114 rows with at least one null value
-- It is possible to Manually impute some of these null values, using stations' coordinates as reference 
-- this will be a time consuming work that wont add much value to our analysis

-- Check for duplicates in station names
SELECT 
  start_station_id
FROM #####.bike_rides.bike_rides
GROUP BY start_station_id
HAVING COUNT (DISTINCT start_station_name)  > 1;

SELECT 
  end_station_id
FROM #####.bike_rides.bike_rides
GROUP BY end_station_id
HAVING COUNT (DISTINCT end_station_name)  > 1;
-- There are at least 88 station ids that correspond to more than one station names

-- Check for duplicates in station ids
SELECT 
  start_station_name
FROM #####.bike_rides.bike_rides
GROUP BY start_station_name
HAVING COUNT (DISTINCT start_station_id)  > 1;

SELECT 
  end_station_name
FROM #####.bike_rides.bike_rides
GROUP BY end_station_name
HAVING COUNT (DISTINCT end_station_id)  > 1;
-- There are at least 48 station names that have more than one station ids

-- Round coordinate values without losing spatial information
UPDATE #####.bike_rides.bike_rides
SET start_lat = ROUND(start_lat, 3)
WHERE true;

UPDATE #####.bike_rides.bike_rides
SET end_lat = ROUND(end_lat, 3)
WHERE true;

UPDATE #####.bike_rides.bike_rides
SET start_lng = ROUND(start_lng, 3)
WHERE true;

UPDATE #####.bike_rides.bike_rides
SET end_lng = ROUND(end_lng, 3)
WHERE true;

-- Remove rides that lasted over 24 hours
DELETE
FROM #####.bike_rides.bike_rides
WHERE TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE) < 0 AND DATE_DIFF(DATE(ended_at), DATE(started_at), DAY) > 0;

-- New tables

-- The results from the query below will saved to a new table named 'date_time'
SELECT 
  member_casual,
  started_at, 
  CAST(DATE(started_at) AS STRING FORMAT 'MONTH') AS month,
  EXTRACT(MONTH FROM started_at) AS n_month,
  CAST(DATE (started_at) AS STRING FORMAT 'DAY') AS day,
  EXTRACT(DAYOFWEEK FROM started_at) AS n_day_week,
  EXTRACT(DAY FROM started_at) AS n_day_month,
  EXTRACT(HOUR FROM started_at) + EXTRACT(MINUTE from started_at) / 100 AS start_time,
  CASE 
    WHEN TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE) < 0 THEN 1440 + TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE)
    ELSE TIME_DIFF(TIME(ended_at), TIME(started_at), MINUTE)
  END AS ride_duration,
  rideable_type
FROM #####.bike_rides.bike_rides;
-- 

-- The results from the query below will be saved to a new table named 'stations'
SELECT  
  start_station_name AS station,
  ROUND(AVG(start_lat),3) AS lat,
  ROUND(AVG(start_lng),3) AS long,
  COUNT(start_station_name) AS num_of_start_rides,
  SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member_rides,
  SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual_rides,
  SUM(CASE WHEN rideable_type = 'electric_bike' THEN 1 ELSE 0 END) AS electric_bike_rides,
  SUM(CASE WHEN rideable_type = 'classic_bike' THEN 1 ELSE 0 END) AS classic_bike_rides,
  SUM(CASE WHEN rideable_type = 'docked_bike' THEN 1 ELSE 0 END) AS docked_bike_rides, 
FROM #####.bike_rides.bike_rides
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY num_of_start_rides;

--------------------------------------------------------------------------------------------------