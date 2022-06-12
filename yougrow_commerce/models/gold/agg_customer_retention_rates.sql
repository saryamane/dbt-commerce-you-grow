with monthly_new_subscribers as (
    select
    first_order_month_year as order_month_year,
    count(distinct customer_id) as cnt_new_subscriber
    from {{ ref('dim_customers') }}
    group by first_order_month_year
    ),

monthly_distinct_customer_purchases as (
    select count(distinct customer_id) as cnt_customer_purchases,
           order_month_year
    from {{ ref('fact_order_line_items') }}
    group by order_month_year
),

retention_rate as (
    select b.order_month_year,
           b.cnt_new_subscriber,
           a.cnt_customer_purchases,
           a.cnt_customer_purchases - b.cnt_new_subscriber as retained_customer_cnt,
           sum(b.cnt_new_subscriber) over (order by b.order_month_year) as running_total_new_subscriber,
           (a.cnt_customer_purchases - b.cnt_new_subscriber) / sum(b.cnt_new_subscriber) over (order by b.order_month_year) * 100 as monthly_retention_rate
    from monthly_distinct_customer_purchases a inner join monthly_new_subscribers b using (order_month_year)
),

final as (
    select order_month_year,
           monthly_retention_rate,
           100 - monthly_retention_rate as monthly_churn_rate
    from retention_rate
)

select * from final