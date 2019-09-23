{{ config(schema="{{var('schema')}}") }}
SELECT
        cnpj_loja,
        Id_similar,
        (fat_item/Qtd_item) :: numeric(18, 2) AS Preco_medio,
        SUM(Qtd_item),
        RANK() OVER (PARTITION BY cnpj_loja, Id_similar ORDER BY SUM(Qtd_item) DESC,(fat_item/Qtd_item) :: numeric(18, 2) DESC ) AS Ordem_moda
    FROM
        {{ref('temp_base_sellout_similar')}}
    WHERE
        TRUE
    GROUP BY
        cnpj_loja,
        Id_similar,
        (fat_item/Qtd_item) :: numeric(18, 2)
