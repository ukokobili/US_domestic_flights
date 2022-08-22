{{ config(materialized='table') }}

with 

a as (
    select *
    from {{ ref('flight_data') }}
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
    a.destination_population
from a
