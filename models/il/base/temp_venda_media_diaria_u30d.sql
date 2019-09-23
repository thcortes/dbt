{{ config(schema="{{var('schema')}}") }}

SELECT
    A.cnpj_loja,	
    A.Sku,
    (Sum(A.Qtd_item) / 30) as venda_media_diaria_loja_sku_u30d
FROM
    {{ref('temp_base_sellout')}} A
WHERE
    TRUE
    AND A."data" > CURRENT_DATE - 31
GROUP BY
    A.cnpj_loja,
    A.Sku
