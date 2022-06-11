{{ config(materialized='table') }}

with stg_customer as (
    select *
    from {{ ref('customer_data') }}
)
select * from stg_customer