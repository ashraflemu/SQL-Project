create schema sql_project_2;

-- PROJECT 2 
-- Select Statement 

-- 1. Retrieve all columns from the `stolen_vehicles` table.

select *
from stolenvehicles;

-- 2. Select only the `vehicle_type`, `make_id`, and `color` columns from the `stolen_vehicles` table. 
-- From Statement

select vehicle_type, make_id, color
from stolenvehicles;

-- 1. Write a query to display all records from the `make_details` table.

select *
from makedetails;

-- 2. Retrieve all columns from the `locations` table.

select *
from location;

-- Where Statement 

-- 1. Find all stolen vehicles that are of type "Trailer".

 select *
 from stolenvehicles
 where vehicle_type like 'trailer';
 
-- 2. Retrieve all stolen vehicles that were stolen after January 1, 2022.\

select *
from stolenvehicles
where date_stolen like '%2022%';

-- 3. Find all stolen vehicles that are of color "Silver".

select vehicle_id, vehicle_type, color
from stolenvehicles
where color like 'silver';

-- Group By and Order By 
-- 1. Count the number of stolen vehicles for each `vehicle_type` and order the results by the count in 
-- descending order.

select  vehicle_type, count(vehicle_id)
from stolenvehicles
group by vehicle_type
order by count(vehicle_id) desc;

-- 2. Find the total number of stolen vehicles for each `make_id` and order the results by `make_id`. 

select vehicle_type, make_id, sum(vehicle_id)
from stolenvehicles
group by vehicle_type, make_id
order by make_id desc;

-- Using Having vs. Where Statement 
-- 1. Find the `make_id` values that have more than 10 stolen vehicles.\

select make_id, count(vehicle_id)
from stolenvehicles
group by make_id
having count(vehicle_id) > 10;

-- 2. Retrieve the `vehicle_type` values that have at least 5 stolen vehicles. 

select vehicle_type, count(vehicle_id)
from stolenvehicles
group by vehicle_type
having count(vehicle_id) >= 5;

-- Limit and Aliasing 
-- 1. Retrieve the first 10 records from the `stolen_vehicles` table and alias the `vehicle_type` column as 
-- "Type".

select vehicle_id, vehicle_type 'Type', make_id, model_year, vehicle_desc, color, date_stolen, location_id
from stolenvehicles
limit 10;

-- 2. Find the top 5 most common colors of stolen vehicles and alias the count column as "Total". 

select vehicle_type, color, count(color) Total
from stolenvehicles
group by vehicle_type, color
order by count(color) desc
limit 5;

-- Joins in MySQL 
-- 1. Join the `stolen_vehicles` table with the `make_details` table to display the `vehicle_type`, 
-- `make_name`, and `color` of each stolen vehicle.

select s.vehicle_type, m.make_name, s.color
from stolenvehicles s
inner join makedetails m
on s.make_id=m.make_id;

-- 2. Join the `stolen_vehicles` table with the `locations` table to display the `vehicle_type`, `region`, and 
-- `country` where the vehicle was stolen.

select s.vehicle_type, l.region, l.country
from stolenvehicles s
inner join location l
on s.location_id=l.location_id;

-- Unions in MySQL 
-- 1. Write a query to combine the `make_name` from the `make_details` table and the `region` from the 
-- `locations` table into a single column.

select make_name
from makedetails
union
select region
from location;

-- PROJECT 2 
-- 2. Combine the `vehicle_type` from the `stolen_vehicles` table and the `make_type` from the 
-- `make_details` table into a single column.

select vehicle_type
from stolenvehicles
union
select make_type
from makedetails;

-- Case Statements 
-- 1. Create a new column called "Vehicle_Category" that categorizes vehicles as "Luxury" if the 
-- `make_type` is "Luxury" and "Standard" otherwise. 

alter table makedetails
add column Vehicle_Category text;
update makedetails
set vehicle_category =
case 
when make_type like 'luxury' then 'Luxury'
else 'Standard'
end;
select *
from makedetails;

-- 2. Use a CASE statement to categorize stolen vehicles as "Old" if the `model_year` is before 2010, "Mid" 
-- if between 2010 and 2019, and "New" if 2020 or later.

select *,
case 
when model_year between 1940 and 2010 then 'Old'
when model_year between 2011 and 2019 then 'Mid'
else 'New'
end as Model_Category
from stolenvehicles;

-- Aggregate Functions 
-- 1. Calculate the total number of stolen vehicles.

select count(vehicle_id) Total_Vehicles_Stolen
from stolenvehicles; 

-- 2. Find the average population of regions where vehicles were stolen.

select region, avg(population)
from location
group by region;

-- 3. Determine the maximum and minimum `model_year` of stolen vehicles. 

select max(model_year)
from stolenvehicles;
select min(model_year)
from stolenvehicles;

-- String Functions 
-- 1. Retrieve the `make_name` from the `make_details` table and convert it to uppercase.

select upper(make_name)
from makedetails;

-- 2. Find the length of the `vehicle_desc` for each stolen vehicle.

select length(vehicle_desc)
from stolenvehicles;

-- 3. Concatenate the `vehicle_type` and `color` columns from the `stolen_vehicles` table into a single 
-- column called "Description".

select concat(vehicle_type, ' ', color) 'Description'
from stolenvehicles;

-- Update Records 
-- 1. Update the `color` of all stolen vehicles with `vehicle_type` "Trailer" to "Black".

update stolenvehicles
set color = 'Black'
where vehicle_type like 'Trailer';
select *
from stolenvehicles;

-- 2. Change the `make_name` of `make_id` 623 to "New Make Name" in the `make_details` table. 

update makedetails
set make_name = 'New Make Name'
where make_id = 623;
select *
from makedetails;

-- Bonus Questions  
-- 1. Write a query to find the top 3 regions with the highest number of stolen vehicles.

select l.region, count(vehicle_id)
from stolenvehicles s
inner join location l
on l.location_id=s.location_id
group by l.region
order by count(vehicle_id) desc
limit 3;

-- 2. Retrieve the `make_name` and the total number of stolen vehicles for each make, but only for makes 
-- that have more than 5 stolen vehicles.

select m.make_name, count(vehicle_id)
from stolenvehicles s
inner join makedetails m
on m.make_id=s.make_id
group by m.make_name
having count(vehicle_id) > 5;

-- 3. Use a JOIN to find the `region` and `country` where the most vehicles were stolen.
select l.region, l.country, count(vehicle_id)

from stolenvehicles s
inner join location l
on l.location_id=s.location_id
group by l.region, l.country
order by count(vehicle_id) desc;

-- 4. Write a query to find the percentage of stolen vehicles that are of type "Boat Trailer".
-- """"""""""""""THIS PARTICULAR QUERY (4) WAS AI ASSISTED""""""""""""""
 select
 cast(sum(case 
 when vehicle_type = 'Boat Trailer'
 then 1 else 0 end)as real)*100/count(*) Percentage_of_BoatTrailer
 from stolenvehicles;
 
-- 5. Use a CASE statement to create a new column called "Density_Category" that categorizes regions as 
-- "High Density" if `density` is greater than 500, "Medium Density" if between 200 and 500, and "Low 
-- Density" if less than 200.

select *,
case
when density > 500 then 'High Density'
when density between 200 and 500 then 'Medium Density'
when density < 200 then 'Low Density'
end as Density_Category
from location;