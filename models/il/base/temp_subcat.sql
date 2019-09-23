{{ config(schema="{{var('schema')}}") }}

SELECT
        A.cnpj_loja,
        A.segmentos,
        A.categoria,
        A.subcategoria,
        Avg(A.tkt_Loja_sku) AS Avg_tkt_Loja_subcat,
        Avg(A.fat_Loja_sku) AS Avg_fat_Loja_subcat,
        Avg(A.qtd_Loja_sku) AS Avg_qtd_Loja_subcat
    FROM
       {{ref('temp_mediana_loja_sku')}} A
    GROUP BY
        A.cnpj_loja,
        A.segmentos,
        A.categoria,
        A.subcategoria