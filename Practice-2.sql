-- Import Practice
-- General syntaxis

COPY table_name
FROM 'C:\YourDirectory\your_file.csv'
WITH (FORMAT CSV, HEADER);



1.- Importing data
1) Create a table

CREATE TABLE us_counties_pop_est_2019 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name	
    county_name text,                        -- County name
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                       -- Area (Water) in square meters
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)
    pop_est_2018 integer,                    -- 2018-07-01 resident total population estimate
    pop_est_2019 integer,                    -- 2019-07-01 resident total population estimate
    births_2019 integer,                     -- Births from 2018-07-01 to 2019-06-30
    deaths_2019 integer,                     -- Deaths from 2018-07-01 to 2019-06-30
    international_migr_2019 integer,         -- Net international migration from 2018-07-01 to 2019-06-30
    domestic_migr_2019 integer,              -- Net domestic migration from 2018-07-01 to 2019-06-30
    residual_2019 integer,                   -- Residual for 2018-07-01 to 2019-06-30
    CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)	
);

2) Make the data (file) available for postgres user 
cp us_counties_pop_est_2019.csv /tmp/

3) Copy the files
COPY us_counties_pop_est_2019
FROM '/tmp/us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER);

4) Indiate columns to import
COPY supervisor_salaries (town, supervisor, salary)
FROM '/tmp/supervisor_salaries.csv' 
WITH (FORMAT CSV, HEADER);

5) Import some records using WHERE
COPY supervisor_salaries (town, supervisor, salary)
FROM '/tmp/supervisor_salaries.csv' 
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';

6) Import temporary table and from ther do an insert
CREATE TEMPORARY TABLE supervisor_salaries_temp 
    (LIKE supervisor_salaries INCLUDING ALL);
    
SELECT * FROM supervisor_salaries_temp;

INSERT INTO supervisor_salaries (town, county, supervisor, salary)
SELECT town, 'Mills', supervisor, salary
FROM supervisor_salaries_temp;

-- Check data
SELECT * FROM supervisor_salaries ORDER BY id LIMIT 2;


2.- Exporting data
1) Export data from a table
COPY us_counties_pop_est_2019
TO '/tmp/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

cp /tmp/us_counties_export.txt 

2) Export data from a select 
COPY (
    SELECT county_name, state_name
    FROM us_counties_pop_est_2019
    WHERE county_name ILIKE '%mill%'
     )
TO '/tmp/us_counties_mill_export.txt'
WITH (FORMAT CSV, HEADER);

cp /tmp/us_counties_mill_export.csv .
