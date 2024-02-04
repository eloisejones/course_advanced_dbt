{% macro age_at_date(
    birthdate,
    comparison_date
) %}
    TRUNCATE(DATEDIFF(MONTH, {{ birthdate }}, {{ comparison_date }})/12)
{% endmacro %}
