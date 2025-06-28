{% macro map_column(provider, column_key, alias=None) %}
  {% set column_mapping = var(provider)['columns'][column_key] %}
  {% set output_alias = alias or column_key %}
  
  {% if column_mapping %}
    {{ column_mapping }} as {{ output_alias }}
  {% else %}
    null as {{ output_alias }}
  {% endif %}
{% endmacro %}