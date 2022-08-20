{{ config(materialized='view') }}

select

  -- flight location
    cast(Origin as string) as origin_code,			
    cast(Destination as string) as destination_code,			
    cast(Origin_City as string) as origin_city,			
    cast(Origin_State as string) as origin_state,				
    cast(Destination_City as string) as destination_city,				
    cast(Destination_State as string) as destination_state,

    -- date
    cast(Date as date) as flight_date,

    -- flight info				
    cast(Passengers as integer) as passengers,			
    cast(Seats as integer) as seats,				
    cast(no_of_flights as integer) as no_of_flights,				
    cast(Distance as numeric) as distance,	

    -- state info			
    cast(Origin_Population as integer) as origin_population,				
    cast(Destination_Population as integer) as destination_population		

from {{ source('staging','flights') }}

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}