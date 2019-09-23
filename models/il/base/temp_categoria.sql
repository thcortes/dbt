
SELECT
        A.cnpj_loja,
        A.segmentos,
        A.categoria,
        Avg(A.tkt_Loja_sku) AS Avg_tkt_Loja_categoria,
        Avg(A.fat_Loja_sku) AS Avg_fat_Loja_categoria,
        Avg(A.qtd_Loja_sku) AS Avg_qtd_Loja_categoria
    FROM
        {{ref('temp_mediana_loja_sku')}} A
    GROUP BY
        A.cnpj_loja,
        A.segmentos,
        A.categoria