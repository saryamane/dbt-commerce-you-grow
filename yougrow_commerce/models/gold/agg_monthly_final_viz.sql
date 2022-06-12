with final_viz as (
    select kpi.order_month_year,
           kpi.monthly_mau,
           kpi.monthly_gmv,
           kpi.monthly_avg_order_value,
           kpi.monthly_cnt_orders,
           cltv.customer_lifetime_value,
           crr.monthly_retention_rate
        from {{ ref('agg_monthly_snap_kpi') }} kpi
        inner join
             {{ ref('agg_customer_lifetime_value') }} cltv
            using (order_month_year)
        inner join {{ ref('agg_customer_retention_rates') }} crr
            using (order_month_year)
    )
select * from final_viz