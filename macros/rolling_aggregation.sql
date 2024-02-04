{% macro rolling_aggregation(
    column_name,
    partition_by,
    order_by='created_at',
    aggregation_function='avg',
    num_rows_preceding=6,
    output_column_name=''
) %}
    {% set output_column_name_template = 'rolling_' ~ aggregation_function~ '_' ~ (num_rows_preceding+1)|string ~ '_rows_' ~ column_name %}
    {% set output_column_name_final = output_column_name if output_column_name != '' else output_column_name_template %}

    {{ aggregation_function }}( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ num_rows_preceding|string }} PRECEDING AND CURRENT ROW
            ) AS {{ output_column_name_final }}
{% endmacro %}
