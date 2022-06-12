{{ config(materialized='table') }}

with stg_customer as (
    select id as customer_id,
           name as customer_name,
           gender as customer_gender,
           email as customer_email,
           state as customer_state,
           country as customer_country,
           state || ', ' || country as customer_location,
           to_timestamp(created_at, 'YYYY-MM-DD HH24:MI:SS') as created_at_ts,
           current_timestamp as etl_load_ts
    from {{ ref('customer_data') }}
)
select * from stg_customer