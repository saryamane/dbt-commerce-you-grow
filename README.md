# dbt-commerce-you-grow

Data model can be found here: https://tinyurl.com/erd-snap

Target database is in PostgresSQL hosted on Heroku.

The final metrics table is: select * from dvgmb960fs5u6.yougrow_commerce.agg_monthly_final_viz;

![Screen Shot 2022-06-12 at 10 01 51 AM](https://user-images.githubusercontent.com/6847378/173244497-45caa2d5-5a52-4eb3-b7e4-c7ba801c3416.png)


## Installation and setup:

This is pre-packaged with the seed csv files, you should be able to clone it, point the PostgresSQL DB of your choice in your profiles.yml file
with the connection information and should be able to run the code.

## Structure:
Models are categorized into 

**Bronze** -> Staged 1:1 with your source files


**Silver** -> Any intermediary computation or data enrichment, by joining across tables


**Gold** -> Certified reportable aggregate tables that can feed directly into your visualization tool of choice.

## Special future use case

Regarding what modification I may need if the owner of you grow decides to include subscription service (per Question # 3).

-> We will capture the types of subscriptions in the dim_subscription object which will capture the levels of subscription type with fee details and % of additional discount on each merchandise.


-> We will then add that subscription code into dim_customer table model as a foreign key.


-> We would also potentially be able to apply merchandise % discount (based on their subscription tiere) on the compute directly within the fact_order_line_item.

## Some Observations:

-> Date field in orders were not consistent. One record had string. Had to manually intervene and change that record (from string to date) to allow the job to work.


-> The refund date is earlier than the order date placed, which does not make sense. Ideally you will want to handle this via dbt test case.


-> The data elements were few, making hard to run any meaningful cohort analysis. However if we get more data, this model can be leveraged to create more agg views using the dim_customer dimensions for different cuts.
