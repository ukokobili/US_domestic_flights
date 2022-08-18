{{ config(materialized='view') }}

select

    -- flight location
    cast(Origin as string) as origin_id,			
    cast(Destination as string) as destination_id,			
    cast(Origin_City as string) as origin_city,			
    Origin_State					
    Destination_City					
    Destination_State	

    -- date
    cast(Date as date) fligt_date,
    				
    Passengers	INTEGER				
    Seats	INTEGER				
    Flights	INTEGER				
    Distance	FLOAT				
    Origin_Population	INTEGER				
    Destination_Population	INTEGER		

from {{ source('staging','flights') }}