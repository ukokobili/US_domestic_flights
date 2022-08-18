{{ config(materialized='view') }}

select

    -- identifiers
    --{{ dbt_utils.surrogate_key(['Origin']) }} as origin_id,

    -- flight location
    cast(Origin as string) as origin_code,			
    cast(Destination as string) as destination_code,			
    cast(Origin_City as string) as origin_city,			
    cast(Origin_State as string) as origin_state,				
    cast(Destination_City as string) as destination_city,				
    cast(Destination_State as string) as destination_state,

    -- date
    cast(Date as date) flight_date,

    -- flight info				
    cast(Passengers as integer) as passengers,			
    cast(Seats	as integer) as seats,				
    cast(Flights as integer) as flights,				
    cast(Distance as float) as distance,	

    -- state info			
    cast(Origin_Population	as integer) as origin_population,				
    cast(Destination_Population	as integer) as destination_population		

from {{ source('staging','flights') }}