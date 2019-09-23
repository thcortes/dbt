
SELECT
    cnpj_loja,
    Sku,
    id_linha,
    Count(*) AS CONT,
    (SUM(fat_item) / SUM(Qtd_item)) :: numeric(18, 2) AS Preco_medio,
	(MIN(fat_item/Qtd_item)) :: numeric(18,2) AS Preco_minimo
FROM
    {{ref('temp_base_sellout2')}}
WHERE
    TRUE
GROUP BY
    cnpj_loja,
    Sku,
    id_linha
