SELECT
        cnpj_loja,
        id_linha,
        Count(*) AS CONT,
        (SUM(fat_item) / SUM(Qtd_item)) :: numeric(18, 2) AS Preco_medio,
		(MIN(fat_item/Qtd_item)) :: numeric(18,2) AS Preco_minimo
    FROM
        dev.temp_Base_Sellout_linha
    WHERE
        TRUE
    GROUP BY
        cnpj_loja,
        id_linha