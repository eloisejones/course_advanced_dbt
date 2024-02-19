# 1. Top 5 costliest dbt queries I've run in the last 30 days

DBT_NODE_ID | TOTAL_COST_LAST_30D | ESTIMATED_ANNUAL_COST
---|---|---
model.dbt_snowflake_monitoring.stg_query_history | 1.156931489 | 13.883177864
model.dbt_snowflake_monitoring.query_history_enriched | 0.6163472869 | 7.396167442
model.dbt_snowflake_monitoring.stg_access_history | 0.6161999695 | 7.394399634
model.dbt_snowflake_monitoring.hourly_spend | 0.4513610654 | 5.416332785
model.dbt_snowflake_monitoring.stg_metering_history | 0.2007817155 | 2.409380585

### Query

```sql
use database DEV;
use schema DBT_ELOISEAMAUNGMAILCOM;

with
max_date as (
    select max(date(end_time)) as date
    from dbt_queries
)
select
    dbt_queries.dbt_node_id,
    sum(dbt_queries.query_cost) as total_cost_last_30d,
    total_cost_last_30d*12 as estimated_annual_cost
from dbt_queries
cross join max_date
where
    dbt_queries.start_time >= dateadd('day', -30, max_date.date)
    and dbt_queries.start_time < max_date.date -- don't include partial day of data
    and dbt_node_id is not null
group by 1
order by total_cost_last_30d desc
limit 5
```

----

# 2. Daily cost of running my most expensive dbt model

DATE | COST
---|---
2024-02-18 | 0.4466981346
2024-02-17 | 0.3113776273
2024-02-16 | 0.1768885574
2024-02-15 | 0.4060518608
2024-02-14 | 0.1427859463
2024-02-13 | 0.0524371424
2024-02-04 | 0.06739035436
2023-12-28 | 0.1456746806
2023-12-01 | 0.000466
2023-11-30 | 0.000494
2023-08-27 | 0.04344886869
2023-08-23 | 0.2681247973
2023-08-20 | 0.08875599566
2023-08-18 | 0.1328094927
2023-08-17 | 0.03378726274
2023-08-15 | 0.01938991999
2023-07-17 | 0.006330641939
2023-07-16 | 0.05396114891

### Query

```sql
use database DEV;
use schema DBT_ELOISEAMAUNGMAILCOM;

select
    date(start_time) as date,
    sum(query_cost) as cost
from dbt_queries
where dbt_node_id = 'model.dbt_snowflake_monitoring.stg_query_history'
group by 1
order by 1 desc
```
