{{ config(materialized='table') }}

with 

flight_record as (
    select * from {{ ref('fact_flights') }}
)
    select 
    origin_city,
    extract(year from flight_date) as flight_year, 
    
    -- calculations
    sum(no_of_flights) as total_yearly_flight_per_airport,
    count(origin_code) as total_yearly_trips,
    avg(passengers) as avg_yearly_passenger_count,
    avg(distance) as avg_yearly_trip_distance

    from flight_record
    group by 1,2