{{ config(materialized='table') }}

with stg_product as (
    select *
    from {{ ref('product_data') }}
)
select * from stg_product