{{ config(schema=target.name) }}

SELECT
    A.cnpj_loja,
    A.id_similar,
    A."data",
    A.tkt_item,
    A.fat_item,
    A.Qtd_item,
    ((A.fat_item) /(A.Qtd_item)) :: numeric(18, 2) AS Preco,
    RANK() OVER (PARTITION BY A.id_similar, A.cnpj_loja ORDER BY A.sku, Preco, A."Data") AS Ordem
FROM
    {{ref('temp_base_sellout')}} A
WHERE
    TRUE
    AND A.id_similar is not null 
    AND A.id_similar <> ' '
