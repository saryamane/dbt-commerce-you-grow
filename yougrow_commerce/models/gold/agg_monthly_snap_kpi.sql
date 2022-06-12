with mau as (
    select count(distinct customer_id) as monthly_mau,
    order_month_year
    from {{ ref('fact_order_line_items') }}
    group by order_month_year
),
gmv as (
    select sum(line_item_selling_total_price) as monthly_gmv,
    order_month_year
    from {{ ref('fact_order_line_items') }}
    group by order_month_year
),
aov as (
    select count(distinct order_id) as monthly_cnt_orders,
           sum(line_item_selling_total_price) / count(distinct order_id) as monthly_avg_order_value,
    order_month_year
    from {{ ref('fact_order_line_items') }}
    group by order_month_year
),

final as (
    select order_month_year,
    mau.monthly_mau,
    gmv.monthly_gmv,
    aov.monthly_avg_order_value,
    aov.monthly_cnt_orders
    from mau inner join gmv using (order_month_year)
    inner join aov using (order_month_year)
    order by order_month_year desc
)

select * from final