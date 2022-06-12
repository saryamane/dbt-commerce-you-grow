{{ config(materialized='table') }}

with stg_order_line_item as (
    select id as order_line_item_id,
           order_id,
           "order_data.customer_id" as customer_id,
           product_id,
           quantity as line_item_qty,
           total_price as selling_total_price,
           total_price / quantity as selling_unit_price,
           "product_data.merchandise_value" as cost_total_price,
           "product_data.merchandise_value" / quantity as cost_unit_price,
           total_price - "product_data.merchandise_value" as contribution_margin
    from {{ ref('order_line_data') }}
)
select * from stg_order_line_item