with product as (
    select *
    from {{ ref('stg_product') }}
),

vendor as (
    select *
    from {{ ref('stg_vendor') }}
),

final as (
    select product.product_id,
    product.product_name,
    product.product_category,
    product.unit_price,
    product.product_cost,
    product.unit_price - product.product_cost as contribution_margin_per_unit,
    vendor.vendor_name
    from product inner join vendor using (vendor_id)
)

select * from final