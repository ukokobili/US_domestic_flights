{{ config(materialized='view') }}

select * 
from from {{ source('staging','flights') }}flights