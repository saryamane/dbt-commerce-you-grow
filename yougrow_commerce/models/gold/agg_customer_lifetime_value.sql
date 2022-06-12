with avg_revenue_per_user as (
    select order_month_year,
           sum(line_item_selling_total_price) / count(distinct customer_id) as avg_rev_per_user
    from {{ ref('fact_order_line_items') }}
    group by order_month_year
),

customer_life_time_period as (
    select first_order_month_year as order_month_year,
           AVG(EXTRACT(DAY FROM  (most_recent_order_date - first_order_date) ) / 30) as average_customer_lifespan
    from {{ ref('dim_customers') }}
    group by first_order_month_year
),

customer_life_time_adjust as (
    select a.order_month_year,
           case when a.average_customer_lifespan = 0 then 1 else a.average_customer_lifespan end as average_customer_lifespan
    from customer_life_time_period a
),

final as (
    select a.order_month_year,
           a.avg_rev_per_user,
           average_customer_lifespan,
           a.avg_rev_per_user * b.average_customer_lifespan as customer_lifetime_value
    from avg_revenue_per_user a inner join  customer_life_time_adjust b using (order_month_year)
)
select * from final
