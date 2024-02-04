{% macro rolling_aggregation(
    column_name,
    partition_by,
    order_by='created_at',
    aggregation_function='avg',
    num_rows_preceding=6
) %}
    {{ aggregation_function }}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN num_rows_preceding PRECEDING AND CURRENT ROW
            ) AS rolling_{{aggregation_function}}_{{num_rows_preceding+1}}_rows_{{ column_name }}
{% endmacro %}
