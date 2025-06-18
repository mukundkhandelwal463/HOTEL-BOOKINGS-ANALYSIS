create database project1;
use project1;
select * from hotel_bookings limit 10;

-- What is the total number of reservations in the dataset? 
select count(*)as reservations from hotel_bookings;
select count(*)as reservations from hotel_bookings where booking_status = "Not_Canceled";

-- Which meal plan is the most popular among guests? 
select type_of_meal_plan , count(*)as no_of_guests_taken from hotel_bookings 
group by type_of_meal_plan ORDER BY no_of_guests_taken DESC LIMIT 1; 

-- What is the average price per room for reservations involving children? 
select avg(avg_price_per_room) as avg_price_per_room from hotel_bookings where no_of_children>0; 

-- How many reservations were made for the year 20XX (replace XX with the desired year)? 
select count(*)as no_of_reservations_in_year_2018 from hotel_bookings where arrival_date  like "%2018";

-- What is the most commonly booked room type? 
select room_type_reserved , count(*)as no_of_guests_taken from hotel_bookings 
group by room_type_reserved ORDER BY no_of_guests_taken DESC LIMIT 1; 


-- What is the highest and lowest lead time for reservations? 
SELECT MAX(lead_time) AS max_lead_time, MIN(lead_time) AS min_lead_time
FROM hotel_bookings;


-- What is the most common market segment type for reservations? 
SELECT market_segment_type, COUNT(*) AS count
FROM hotel_bookings
GROUP BY market_segment_type
ORDER BY count DESC
LIMIT 1;


-- What is the total number of adults and children across all reservations? 
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM hotel_bookings;


-- Rank room types by average price within each market segment. 
SELECT market_segment_type, room_type_reserved,
       AVG(avg_price_per_room) AS avg_price
FROM hotel_bookings
GROUP BY market_segment_type, room_type_reserved
ORDER BY market_segment_type, avg_price DESC;


-- Find the top 2 most frequently booked room types per market segment. 
SELECT market_segment_type, room_type_reserved, bookings
FROM (
  SELECT market_segment_type, room_type_reserved,
         COUNT(*) AS bookings,
         RANK() OVER (PARTITION BY market_segment_type ORDER BY COUNT(*) DESC) AS 'rank'
  FROM hotel_bookings
  GROUP BY market_segment_type, room_type_reserved
) AS ranked
WHERE 'rank' <= 2;


-- What is the average number of nights (both weekend and weekday) spent by guests for each room type? 
SELECT room_type_reserved,
       AVG(no_of_weekend_nights + no_of_week_nights) AS avg_total_nights
FROM hotel_bookings
GROUP BY room_type_reserved;


-- For reservations involving children, what is the most common room type, and what is the average price for that room type? 
SELECT room_type_reserved,
       COUNT(*) AS bookings,
       AVG(avg_price_per_room) AS avg_price
FROM hotel_bookings
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY bookings DESC
LIMIT 1;


--  Find the market segment type that generates the highest average price per room. 
 SELECT market_segment_type,
       AVG(avg_price_per_room) AS avg_price
FROM hotel_bookings
GROUP BY market_segment_type
ORDER BY avg_price DESC
LIMIT 1;

