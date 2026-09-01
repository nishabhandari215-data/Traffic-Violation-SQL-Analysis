create database traffic_dataset;
use traffic_dataset;

-- Delhi Traffic Violations Dataset (2024–2026) - SQL
-- PART 1 — SELECT, FROM, DISTINCT, WHERE, String Functions, Operators (25 Qs)
-- 1. Show all violations recorded in "Dwarka" zone

select 
violation_type , Delhi_Location 
from fact_violation
where Delhi_Location ="Dwarka";

-- 2. List all distinct violation types we track

select 
 distinct violation_type
from fact_violation;


-- 3. Show all vehicles registered in Delhi

select 
*
from  dim_vehicle
where Registration_State = "Delhi";

-- 4. Find all challans where fine amount is more than ₹5000
select 
* from fact_violation
where fine_amount>5000;


select 
distinct  violation_type , fine_amount from fact_violation
where Fine_Amount >=5000;


-- 5. Show violations between ₹1000 and ₹5000 (inclusive)

select * , 
case
When fine_amount between 1000 and 5000 then "fair"
end AS cust_inr_status
from fact_violation;

select *
from fact_violation
where fine_amount between 1000 and 5000 ;

-- 6. List all female officers... (N/A — officers don't have gender; use) List all officers
-- with rank "Inspector"

select*from dim_officer;

select *  from dim_officer
where `Rank` ="Inspector"  ;

-- 7. Show all vehicle owners aged between 25 and 40
select *
from dim_vehicle
where Owner_age between 25 and 40 ;

-- 8. Find all "Over-speeding" OR "Drunk Driving" violations
select * from fact_violation
where violation_type ="Over-speeding"  or violation_type="Drunk Driving" ;

-- 9. Show violations that are NOT "Improper Parking"
select * from fact_violation
where violation_type !="Improper Parking";

-- 10.List all vehicle numbers that start with "DL"
select * from dim_vehicle
where Vehicle_Number like "DL%";
-- 11.Find all officers whose Officer_ID contains "88"
select * from dim_officer
where officer_id like "%88%";

-- 12.Show violation types in UPPERCASE
select *, upper( violation_type )from fact_violation;

-- 13.Show vehicle owner names... (no name field — use) Show Registration_State in
-- lowercase
select *, lower(Registration_State) from dim_vehicle;

-- 14.Find length of each Vehicle_Number (to check formatting consistency)
select *,length( Vehicle_Number)from dim_vehicle;

select count(Vehicle_Number)from dim_vehicle;
-- 15.Trim any extra spaces from Violation_Type before matching
select *,trim(Violation_Type)from fact_violation;

select *from fact_violation
where trim(violation_type) ="over-speeding";

-- 16.Show first 2 characters of each Vehicle_Number (to check RTO code)
select  *,substring(vehicle_number,1,2 )as two_char from dim_vehicle;

-- 17.Concatenate Violation_Type and Delhi_Location into one column
-- ("Over-speeding in Dwarka")

select * , concat(Violation_Type ,"  " , Delhi_Location)as concat_table from fact_violation
where Violation_Type="over-speeding" and Delhi_location ="Dwarka";

-- 18.Show all violations where Fine_Paid is either "Yes" or blank/NULL
select * from fact_violation
where fine_paid ="yes" or fine_paid is null;

-- 19.Find all vehicles with missing (NULL) Owner_Age
select * from dim_vehicle 
where owner_age is null;

 SELECT vehicle_type, Owner_age
FROM dim_vehicle
WHERE Owner_age IS NULL;
-- 20.Show violations recorded on weekends only (needs DAYOFWEEK)

SELECT Date,
       DAYNAME(STR_TO_DATE(Date, '%m/%d/%Y')) AS day_name
FROM fact_violation
WHERE DAYOFWEEK(STR_TO_DATE(Date, '%m/%d/%Y')) IN (1, 7);
select * from fact_violation
where dayofweek(str_to_date(date, '%m/%d/%y')) in (1 ,7);

-- 21.List violations that happened in January 2025
SELECT *
FROM fact_violation
WHERE MONTH(STR_TO_DATE(Date, '%m/%d/%Y')) = 1
  AND YEAR(STR_TO_DATE(Date, '%m/%d/%Y')) = 2025;

-- 22.Show all vehicles older than model year 2015 AND registered in Delhi
select * from dim_vehicle
where model_year <=2015 and Registration_State ="Delhi";

-- 23.Find officers NOT belonging to "Delhi Traffic Police" agency
select * from dim_officer
where Issuing_Agency != "Delhi Traffic Police";

-- 24.Show top 10 highest fine amounts (just SELECT + ORDER + LIMIT preview)
select * from fact_violation
order by fine_amount desc
limit 10;

-- 25.List all unique Delhi zones where violations occurred
select distinct Delhi_Location from fact_violation;

SELECT Delhi_Location, COUNT(*) AS total_violations
FROM fact_violation
GROUP BY Delhi_Location;




