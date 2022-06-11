{{ config(materialized='table') }}

with stg_order_line_item as (
    select *
    from {{ ref('order_line_data') }}
)
select * from stg_order_line_item