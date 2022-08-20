{{ config(materialized='table') }}

select
    state_code,
    airport_type,
    airport_name,
    lat_lon,
    city
from {{ ref('us_cities_codes') }}