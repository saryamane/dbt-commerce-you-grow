{{ config(materialized='table') }}

with stg_vendor as (
    select *
    from {{ ref('vendor_data') }}
)
select * from stg_vendor