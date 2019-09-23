    {{ config(schema="{{var('schema')}}") }}
    
    SELECT
        A.cnpj_loja,
        A.segmentos,
        Avg(A.tkt_Loja_sku) AS Avg_tkt_Loja_segmento,
        Avg(A.fat_Loja_sku) AS Avg_fat_Loja_segmento,
        Avg(A.qtd_Loja_sku) AS Avg_qtd_Loja_segmento
    FROM
        {{ref('temp_mediana_loja_sku')}} A
    GROUP BY
        A.cnpj_loja,
        A.segmentos