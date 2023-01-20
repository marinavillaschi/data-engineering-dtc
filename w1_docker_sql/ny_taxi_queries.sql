-- Q3
select count(*) from green_taxi
where date(lpep_pickup_datetime) between date('2019-01-15') and date('2019-01-15')
and date(lpep_dropoff_datetime) between date('2019-01-15') and date('2019-01-15')


-- Q4
select date(lpep_pickup_datetime), max(trip_distance) as largest_trip_distance
from green_taxi 
group by 1
order by 2 desc


-- Q5
select count(*) filter (where passenger_count = 2) as two_passengers
, count(*) filter (where passenger_count = 3) as three_passengers
from green_taxi 
where date(lpep_pickup_datetime) between date('2019-01-01') and date('2019-01-01')
--and date(lpep_dropoff_datetime) between date('2019-01-01') and date('2019-01-01')


-- Q6
select "PULocationID", zpu."Zone" as "PUZone", "DOLocationID", zdo."Zone" as "DOZone", tip_amount
from green_taxi
inner join zones zpu
	on green_taxi."PULocationID" = zpu."LocationID"
inner join zones zdo
	on green_taxi."DOLocationID" = zdo."LocationID"
where zpu."Zone" = 'Astoria'
order by tip_amount desc 
limit 1
