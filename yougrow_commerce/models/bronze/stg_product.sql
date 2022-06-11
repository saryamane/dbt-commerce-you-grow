{{ config(materialized='table') }}

with stg_product as (
    select product as product_id,
           title as product_name,
           category as product_category,
           price as unit_price,
           cost as product_cost,
           vendor as vendor_id,
           created_at,
           current_timestamp as etl_load_ts
    from {{ ref('product_data') }}
)
select * from stg_product