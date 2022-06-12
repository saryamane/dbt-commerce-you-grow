{{ config(materialized='table') }}

with stg_order as (
    select id as order_id,
           customer_id,
           currency,
           total_price,
           total_quantity as total_qty,
           to_timestamp(created_at, 'YYYY-MM-DD HH24:MI:SS') as order_create_ts,
           to_timestamp(refunded_at, 'YYYY-MM-DD HH24:MI:SS') as refunded_at_ts,
           case when refunded_at is null then 'Active' else 'Refunded' end as order_status,
           current_timestamp as etl_load_ts
    from {{ ref('order_data') }}
)
select * from stg_order