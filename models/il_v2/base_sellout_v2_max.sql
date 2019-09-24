{{ config(schema=target.name, tags="il_v2") }}

SELECT
    A.cnpj_loja,
    A.Sku,
    max(A.tkt_item) as tkt_item,
    max(A.fat_item) as fat_item,
    max(A.Qtd_item) as Qtd_item,
    max(((A.fat_item) /(A.Qtd_item)) :: numeric(18, 2)) AS Preco
FROM
    {{ref(var('temp_base_sellout2'))}}  A
WHERE
    TRUE
GROUP BY 
    A.cnpj_loja,
    A.Sku