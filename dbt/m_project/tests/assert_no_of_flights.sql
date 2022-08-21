-- Refunds have a negative amount, so the number of flight should always be >= 0.
-- Therefore return records where this isn't true to make the test fail

with 

no_of_flights_test as (
    select * from {{ ref('fact_flights' )}}
)

select
    origin_city,
    no_of_flights
from 
    no_of_flights_test
where 
    no_of_flights < 1