{{ config(materialized='view') }}

select * from {{ source ('staging','flights') }}
limit 100