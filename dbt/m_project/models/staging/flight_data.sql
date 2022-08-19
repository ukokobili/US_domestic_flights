{{ config(materialized='view') }}

select

  -- flight location
    Origin as origin_code,			
    Destination as destination_code,			
    Origin_City as origin_city,			
    Origin_State as origin_state,				
    Destination_City as destination_city,				
    Destination_State as destination_state,

    -- date
    Date as flight_date,

    -- flight info				
    Passengers as passengers,			
    Seats as seats,				
    Flights as no_of_flights,				
    Distance as distance,	

    -- state info			
    Origin_Population as origin_population,				
    Destination_Population as destination_population		

from {{ source('staging','flights') }}

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}