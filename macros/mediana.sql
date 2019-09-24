{% macro mediana(valor_total, qtde_total ) %}
    (valor_total / qtde_total) :: numeric(18, 2)
{% endmacro %}