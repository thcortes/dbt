{{ config(schema=target.name) }}

SELECT
        cnpj_loja,
        id_similar,
        Count(*) AS CONT,
        (SUM(fat_item) / SUM(Qtd_item)) :: numeric(18, 2) AS Preco_medio,
		(MIN(fat_item/Qtd_item)) :: numeric(18,2) AS Preco_minimo
    FROM
        {{ref('temp_base_sellout_similar')}}
    WHERE
        TRUE
    GROUP BY
        cnpj_loja,
        id_similar