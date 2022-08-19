{{ config(materialized='table') }}

select
    city_code,			
    lat,			
    lon
from {{ ref('us_cities_codes') }}