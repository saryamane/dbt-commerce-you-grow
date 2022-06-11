{{ config(materialized='table') }}

with stg_vendor as (
    select id as vendor_id,
           title as vendor_name,
           created_at,
           current_timestamp as etl_load_ts
    from {{ ref('vendor_data') }}
)
select * from stg_vendor