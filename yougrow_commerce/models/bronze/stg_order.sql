{{ config(materialized='table') }}

with stg_order as (
    select *
    from {{ ref('order_data') }}
)
select * from stg_order