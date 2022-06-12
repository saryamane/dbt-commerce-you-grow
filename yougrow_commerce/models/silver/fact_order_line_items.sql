with final as (
    select oli.order_line_item_id,
           oli.order_id,
           o.currency,
           o.order_status,
           o.total_price as order_total_price,
           oli.customer_id,
           oli.product_id,
           p.product_name,
           p.product_category,
           p.vendor_name,
           oli.line_item_qty,
           oli.selling_total_price as line_item_selling_total_price,
           oli.selling_unit_price as line_item_selling_unit_price,
           oli.cost_total_price as line_item_cost_total_price,
           oli.cost_unit_price as line_item_cost_unit_price,
           oli.contribution_margin as line_item_contribution_margin
    from  {{ ref('stg_order_line_item') }} oli, {{ ref ('stg_order') }} o, {{ ref('dim_customers') }} c, {{ ref('dim_products') }} p
    where oli.order_id = o.order_id
    and oli.customer_id = c.customer_id
    and oli.product_id = p.product_id
)
select * from final