{{ config(schema=target.name) }}

SELECT
        cnpj_loja,
        id_linha,
        Count(*) AS CONT,
        {{ mediana( 'SUM(fat_item)' , 'SUM(Qtd_item)' ) }} AS Preco_medio_macro,
        (SUM(fat_item) / SUM(Qtd_item)) :: numeric(18, 2) AS Preco_medio,
		(MIN(fat_item/Qtd_item)) :: numeric(18,2) AS Preco_minimo
    FROM
        {{ref(var('temp_base_sellout_linha'))}} 
    WHERE
        TRUE
    GROUP BY
        cnpj_loja,
        id_linha