SELECT *
FROM citibike_stations;

SELECT *
FROM citibike_2016
LIMIT 5;

--id, latitude, longitude, name, docks
--start_time, stop_time, start_station_id, end_station_id, bike_id, user_type, birth_year, gender

--Which is the most used start station in 2016?
SELECT st.name, a.start_station_id, COUNT (a.start_station_id) count_of_start_station
FROM citibike_2016 a
JOIN citibike_stations st
	ON a.start_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used start station in 2017?
SELECT st.name, b.start_station_id, COUNT (b.start_station_id) count_of_start_station
FROM citibike_2017 b
JOIN citibike_stations st
	ON b.start_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used start station in 2018?
SELECT st.name, c.start_station_id, COUNT (c.start_station_id) count_of_start_station
FROM citibike_2018 c
JOIN citibike_stations st
	ON c.start_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used start station in 2019?
SELECT st.name, d.start_station_id, COUNT (d.start_station_id) count_of_start_station
FROM citibike_2019 d
JOIN citibike_stations st
	ON d.start_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Most used start station UNION 2016-2019:
SELECT st.name, start_station_id, COUNT (start_station_id)
FROM (
		SELECT start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT start_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = start_station_id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used end station in 2016?
SELECT st.name, a.end_station_id, COUNT (a.end_station_id) count_of_end_station
FROM citibike_2016 a
JOIN citibike_stations st
	ON a.end_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used end station in 2017?
SELECT st.name, b.end_station_id, COUNT (b.end_station_id) count_of_end_station
FROM citibike_2017 b
JOIN citibike_stations st
	ON b.end_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used end station in 2018?
SELECT st.name, c.end_station_id, COUNT (c.end_station_id) count_of_end_station
FROM citibike_2018 c
JOIN citibike_stations st
	ON c.end_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Which is the most used end station in 2019?
SELECT st.name, d.end_station_id, COUNT (d.end_station_id) count_of_end_station
FROM citibike_2019 d
JOIN citibike_stations st
	ON d.end_station_id = st.id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Most used end station UNION 2016-2019:
SELECT st.name, end_station_id, COUNT (end_station_id)
FROM (
		SELECT end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT end_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = end_station_id
GROUP BY 2, 1
ORDER BY 3 DESC;

--Are there any trips with no start stations?
SELECT start_station_id
FROM (
		SELECT start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT start_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2019) AS T1
WHERE start_station_id IS NULL;


--Are there any trips with no end stations?
SELECT end_station_id
FROM (
		SELECT end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT end_station_id
		FROM citibike_2019) AS T1
WHERE end_station_id IS NULL;


--How many rides were from subscribers and customers in 2016-2019?
SELECT user_type, COUNT (user_type)
FROM (
		SELECT start_time, user_type
		FROM citibike_2016 
		UNION ALL
		SELECT start_time, user_type
		FROM citibike_2017
		UNION ALL
		SELECT start_time, user_type
		FROM citibike_2018 
		UNION ALL
		SELECT start_time, user_type
		FROM citibike_2019) AS T1
GROUP BY 1;

-- What is the distribution of start of rides within 24 hours?
SELECT DATE_PART ('hour', start_time) AS Hour_of_day, COUNT (start_time)
FROM (
		SELECT start_time, start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT  start_time, start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT  start_time, start_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT  start_time, start_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = start_station_id
GROUP BY 1;


-- What is the distribution of end of rides within 24 hours?
SELECT DATE_PART ('hour', stop_time) AS Hour_of_day, COUNT (stop_time)
FROM (
		SELECT stop_time, end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = end_station_id
GROUP BY 1;


-- What is the distribution of end of rides within the year?
SELECT DATE_PART ('month', stop_time) AS month, COUNT (stop_time)
FROM (
		SELECT stop_time, end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT  stop_time, end_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = end_station_id
GROUP BY 1;



-- What are popular routes? (Table Name: poproutes)
SELECT sts.name start_name, T1.start_station_id, ste.name end_name, T1.end_station_id, COUNT (*) trip_count
INTO TEMP poproutes
FROM (
		SELECT start_time, start_station_id, end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations sts
	ON start_station_id = sts.id
JOIN citibike_stations ste
	ON end_station_id = ste.id	
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;

SELECT *
FROM poproutes
LIMIT 5; -- poproutes (start_name, start_station_id, end_name, end_station_id, trip_count)


SELECT pop.start_name, pop.start_station_id, sts.latitude AS start_lat, sts.longitude AS start_long, pop.end_name, pop.end_station_id, pop.trip_count
INTO TEMP poproutes1
from poproutes pop
LEFT JOIN citibike_stations sts
	ON start_station_id = sts.id;

SELECT *
FROM poproutes1
LIMIT 5; -- poproutes1 (start_name, start_station_id, start_lat, start_long, end name, end_station_id)


SELECT pop1.start_name, pop1.start_station_id, pop1.start_lat, pop1.start_long, pop1.end_name, pop1.end_station_id, sts.latitude AS end_lat, sts.longitude AS end_long
INTO TEMP poproutes2
FROM poproutes1 pop1
LEFT JOIN citibike_stations sts
	ON pop1.end_station_id = sts.id;
	
SELECT *
FROM poproutes2
LIMIT 5; -- poproutes2 (start_name, start_station_id, start_lat, start_long, end name, end_station_id, end_lat, end_long)

--DROP TEMP poproutes -- Maybe?


--Manhattan Distance? Convert latitude and longitude to radians.
With radians AS (SELECT start_name, start_station_id, start_lat/180 * 3.14159265359 AS start_lat_radians, start_long/180 * 3.14159265359 AS start_long_radians,
						end_name, end_station_id, end_lat/180 * 3.14159265359 AS end_lat_radians, end_long/180 * 3.14159265359 AS end_long_radians
					FROM poproutes2
					)

--Manhattan Distance? Actual calculation? WORK IN PROGRESS
--acos(sin(start lat)*sin(end lat)+cos(start lat)*cos(end lat)*cos(end long-start long))*3959 (miles) *6371 (km)
SELECT start_name, start_station_id, end_name, end_station_id, 
		CASE
			WHEN start_name LIKE end_name THEN 0
			WHEN start_name NOT LIKE end_name THEN 
				(ACOS(SIN(start_lat_radians) * SIN(end_lat_radians) + (COS(start_lat_radians) * COS(end_lat_radians) * COS(end_long_radians - start_long_radians)))*3959)
		END AS distance_miles,
		CASE
			WHEN start_name LIKE end_name THEN 0
			WHEN start_name NOT LIKE end_name THEN 
				(ACOS(SIN(start_lat_radians) * SIN(end_lat_radians) + (COS(start_lat_radians) * COS(end_lat_radians) * COS(end_long_radians - start_long_radians)))*6371)
		END AS distance_kms
FROM radians;



--What is the average duration of a ride? (Mean and Median) - DO THIS ON POWERBI INSTEAD TO SEE OUTLIERS.
SELECT start_station_id, end_station_id, AVG(stop_time - start_time) AS avg_duration
FROM (
		SELECT start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2016 
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2017
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2018 
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2019
	 ) AS duration
GROUP BY start_station_id, end_station_id


SELECT start_station_id, end_station_id, MAX(stop_time - start_time) + MIN(stop_time - start_time) / 2 AS median_duration
FROM (
		SELECT start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2016 
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2017
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2018 
		UNION ALL
		SELECT  start_station_id, start_time, end_station_id, stop_time
		FROM citibike_2019
	 ) AS duration
GROUP BY start_station_id, end_station_id;

-- How much is the minimum income per month from bikesharing?
--DO NOT USE. Cannot account for how many are distinct Subscribers. Cannot acccount for how many are single rides and day passes from customers.
--Use data from monthly reports.
SELECT DATE_PART('month', start_time) AS month_2016, user_type, COUNT(DISTINCT start_time)::money * 4.49 AS revenue_from_customer
FROM citibike_2016
WHERE user_type like 'Customer'
GROUP BY month_2016, user_type;


--How many bicycles are there in total (2019)? -- 1699
SELECT COUNT(DISTINCT bike_id)
FROM (
		SELECT bike_id
		FROM citibike_2016 
		UNION
		SELECT  bike_id
		FROM citibike_2017
		UNION
		SELECT  bike_id
		FROM citibike_2018 
		UNION
		SELECT  bike_id
		FROM citibike_2019
	 ) AS bikes;
	 
SELECT COUNT(DISTINCT bike_id) --2016 --566
FROM citibike_2016;

SELECT COUNT(DISTINCT bike_id) --2016 & 2017 --1335
FROM (
		SELECT start_time, bike_id
		FROM citibike_2016 
		UNION
		SELECT start_time, bike_id
		FROM citibike_2017
	 ) AS bikes
GROUP BY DATE_TRUNC('year', start_time); -- Adding this gives a different answer? 1201+566
	 
SELECT COUNT(DISTINCT bike_id) -- 2016, 2017 & 2018 -1599
FROM (
		SELECT start_time, bike_id
		FROM citibike_2016 
		UNION
		SELECT start_time, bike_id
		FROM citibike_2017
		UNION
		SELECT start_time, bike_id
		FROM citibike_2018 
	 ) AS bikes
GROUP BY DATE_TRUNC('year', start_time); -- Adding this gives a different answer? 903+1201+566



--Number of stations in JC (2019)?
SELECT COUNT(DISTINCT start_station_id)-- 63
FROM (
		SELECT start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT start_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2019) AS stations;
		
SELECT COUNT(DISTINCT start_station_id) --2016 - 51
FROM citibike_2016;

SELECT COUNT(DISTINCT start_station_id) --2016 & 2017 - 55
FROM (
		SELECT start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2017) AS stations;
		
SELECT COUNT(DISTINCT start_station_id)-- 2016, 2017 & 2018 - 61
FROM (
		SELECT start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT start_station_id
		FROM citibike_2018) AS stations; 

SELECT COUNT(DISTINCT start_station_id) -- None total to 63?
FROM (
		SELECT start_time, start_station_id
		FROM citibike_2016 
		UNION
		SELECT start_time, start_station_id
		FROM citibike_2017
		UNION
		SELECT start_time, start_station_id
		FROM citibike_2018 
		UNION
		SELECT start_time, start_station_id
		FROM citibike_2019) AS stations
GROUP BY DATE_TRUNC('year', start_time);


--Number of Docks: -- IN PROGRESS
SELECT COUNT(st.docks)
FROM (
		SELECT start_time, start_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT start_time, start_station_id
		FROM citibike_2017
		UNION ALL
		SELECT start_time, start_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT start_time, start_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations st
	ON st.id = start_station_id
GROUP BY DATE_TRUNC('year', t1.start_time), start_station_id


--For Ride locations
SELECT sts.name start_name, T1.start_station_id, ste.name end_name, T1.end_station_id, COUNT (*) trip_count
INTO TEMP poproutesrides
FROM (
		SELECT start_time, start_station_id, end_station_id
		FROM citibike_2016 
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2017
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2018 
		UNION ALL
		SELECT  start_time, start_station_id, end_station_id
		FROM citibike_2019) AS T1
JOIN citibike_stations sts
	ON start_station_id = sts.id
JOIN citibike_stations ste
	ON end_station_id = ste.id	
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;

SELECT *
FROM poproutesrides
LIMIT 5; -- poproutes (start_name, start_station_id, end_name, end_station_id, trip_count)


SELECT pop.start_name, pop.start_station_id, sts.latitude AS start_lat, sts.longitude AS start_long, pop.end_name, pop.end_station_id, pop.trip_count
INTO TEMP poproutesrides1
from poproutes pop
LEFT JOIN citibike_stations sts
	ON start_station_id = sts.id;

SELECT *
FROM poproutesrides1;



--Unioned all years table: --1,301,351 Rows
SELECT *
FROM citibike_2016 
UNION ALL
SELECT *
FROM citibike_2017
UNION ALL
SELECT *
FROM citibike_2018 
UNION ALL
SELECT *
FROM citibike_2019