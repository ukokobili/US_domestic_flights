{{ config(materialized='table') }}

with a as (
    select *
    from {{ ref('flight_data') }}
), 

b as (
    select * 
    from {{ ref('dim_code') }}
)
select
    a.origin_code,				
    a.destination_code,					
    a.origin_city,					
    a.origin_state,					
    a.destination_city,					
    a.destination_state,					
    a.flight_date,				
    a.passengers,				
    a.seats,				
    a.no_of_flights,				
    a.distance,				
    a.origin_population,				
    a.destination_population,
    x.airport_name as origin_airport,
    x.lat_lon as origin_lat_lon,
    y.airport_name as destination_airport,
    y.lat_lon as destination_lat_lon
from a
inner join b as x
on a.origin_city = x.city
inner join b as y
on a.destination_city = y.city