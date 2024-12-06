/* Once database has been created on Postgres and data imported via pgAdmin 4, I combined all csv files into a single one to clean it in one go and make my analysis easier. This way, I will have all the data accessible in one and only dataset.

Query used to do this step */

create table analysis as 
    select * from oct_2023
    union
    select * from nov_2023
    union
    select * from dec_2023
    union
    select * from jan_2024
    union
    select * from feb_2024
    union
    select * from mar_2024
    union
    select * from apr_2024
    union
    select * from may_2024
    union
    select * from jun_2024
    union
    select * from jul_2024
    union 
    select * from aug_2024
    union
    select * from sep_2024;

/* Once our data is merged into one first step is to verify if our primary key (ride_id) is unique and still contains 16 characters. 
Here are queries used to do so : */

SELECT LENGTH(ride_id), count(*), COUNT (DISTINCT ride_id)
FROM analysis
GROUP BY LENGTH(ride_id);

/* First query returns us a total of 5854544 entries while second query returns a total of million 5 854 333. It means there is duplicates ride_id entries. Besides this, all entries contains 16 characters. 

To check why there is duplicates, we’re going to use this query to see which ride_id have duplicates and then choose a specific ride_id : */

SELECT ride_id, started_at
FROM analysis
WHERE (ride_id) IN (
    SELECT ride_id
    FROM analysis
    GROUP BY ride_id
    HAVING COUNT(*) > 1
	ORDER BY ride_id ASC);

/* We see that all duplicates follows the same pattern. One entry contains started_at and ended_at with milliseconds while the other one doesn’t. Since milliseconds are not relevant to our study, we are simply going to remove them and keep started_at and ended_at as HH:MM:SS format time wise.

Query used : */
  UPDATE analysis
SET started_at = DATE_TRUNC('second', started_at),
    ended_at = DATE_TRUNC('second', ended_at);

/* Once our query is done, we can create another table using DISTINCT() in order to get rid of duplicates. */

CREATE TABLE clean_analysis AS
SELECT DISTINCT *
FROM analysis

/* After rerunning our primary key checking query, we can see that COUNT() and COUNT(DISTINCT) returns the same number, meaning all duplicates has been deleted.

Now we can take care of null values seen when overlooking our data. We can get it again with this query : */

SELECT *
FROM clean_analysis
WHERE ride_id IS NULL
OR rideable_type IS NULL
OR started_at IS NULL
OR ended_at IS NULL
OR start_station_name IS NULL
OR start_station_id IS NULL
OR end_station_name IS NULL
OR end_station_id IS NULL
OR start_lat IS NULL
OR start_lng IS NULL
OR end_lat IS NULL
OR end_lng IS NULL
OR member_casual IS NULL;
/* The majority of our NULL data are missing starting and ending station names as long as their id and coordinates. For our analysis, station id isn’t necessary so we can get rid of them. We will also get rid of every row containing NULL values since it will false our results.

Query used to drop columns */

ALTER TABLE clean_analysis
DROP COLUMN start_station_id, 
DROP COLUMN end_station_id,

/* To delete NULL values we can take our previous query and replace SELECT * with DELETE. 

After this query 1 626 238 has been deleted.

Once all NULL values has been deleted, we can check other column for other mistakes/irrelevant data */

SELECT DISTINCT member_casual
from clean_analysis

/* Only two type : member and casual */

SELECT DISTINCT rideable_type
from clean_analysis

/* Only three types : classic_bikes, electric_bikes, electric_scooter. Since electric scooter are not considered as bikes (standing on it and having no pedals), we will need to remove their entries.*/

delete from clean_analysis
where rideable_type = 'electric_scooter';

/* 47827 entries has been deleted after this query

As part of our study, we will add new columns : day_of_week and month showing which day/ month the trip is taken place and trip_length to show how long the trip lasted
*/

ALTER TABLE clean_analysis
ADD COLUMN day_of_week TEXT,
ADD COLUMN month TEXT,
ADD COLUMN trip_length INTERVAL;

UPDATE clean_analysis
SET day_of_week = TO_CHAR(started_at, 'Day'),
	month = TO_CHAR(started_at, 'Month'), 
	trip_length = ended_at - started_at;

/* After verification, we see negative values and trips lasting less than a minute. Negatives values are done by starting date been anterior to ending date and less than a minute can be explained by users making sure the bike is nicely reattached. For our study, we are going to delete trips lasting less that a minute. 
*/

delete
from clean_analysis
where trip_length < '00:01:00';

/* We are going to do the same for trips lasting a day or more for more equality */

delete
from clean_analysis
where trip_length >= '1 day';


/* After these steps, our dataset is cleaned and ready to be analyzed on tableau.*/
