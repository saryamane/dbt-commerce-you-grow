with customers as (
    select *
    from {{ ref ('stg_customer')}}
),

orders as (
    select *
    from {{ ref ('stg_order') }}
),

customer_orders as (
    select customer_id,
           min(order_create_ts) as first_order_date,
           max(order_create_ts) as most_recent_order_date,
           sum(total_price) as total_purchase_amount,
           count(order_id) as total_orders_placed,
           sum(total_price)/count(order_id) as average_order_amount
    from orders
    group by customer_id
),

final as (
    select customers.customer_id,
           customers.customer_name,
           customers.customer_email,
           customers.customer_location,
           customers.customer_gender,
           customer_orders.first_order_date,
           to_char(customer_orders.first_order_date, 'YYYYMM') as first_order_month_year,
           customer_orders.most_recent_order_date,
           to_char(customer_orders.most_recent_order_date, 'YYYYMM') as most_recent_order_month_year,
           coalesce(customer_orders.total_orders_placed,0) as number_of_orders,
           coalesce(customer_orders.total_purchase_amount,0) as total_revenue,
           coalesce(customer_orders.average_order_amount,0) as avg_order_amount
    from customers
    left join customer_orders using (customer_id)
)

select * from final