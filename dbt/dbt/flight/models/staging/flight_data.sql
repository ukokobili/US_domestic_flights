{{ config(materialized='view') }}

select * from {{ source('staging','us-domestic-flights') }}