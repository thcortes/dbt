
SELECT
    A.cnpj_loja,
    A.Sku,
    A.id_linha,
    A.id_Similar,
    A.segmentos,
    A.categoria,
    A.subcategoria,
    A."data",
    A.tkt_item,
    A.fat_item,
    A.Qtd_item,
    ((A.fat_item) /(A.Qtd_item)) :: numeric(18, 2) AS Preco,
    RANK() OVER ( PARTITION BY A.Sku, A.cnpj_loja ORDER BY Preco, A."Data" ) AS Ordem
FROM
    {{ref('temp_base_sellout')}} A
WHERE
    TRUE