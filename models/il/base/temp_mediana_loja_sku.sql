{{ config(schema=target.name) }}

SELECT
        A.cnpj_loja,
        A.Sku,
        A.id_linha,
        A.id_similar,
        A.segmentos,
        A.categoria,
        A.subcategoria,
        A.Cont,
        Sum(A.tkt_item) AS tkt_Loja_sku,
        Sum(A.fat_item) AS fat_Loja_sku,
        Sum(A.qtd_item) AS qtd_Loja_sku,
        SUM(A.MEDIANA * A.Preco) :: NUMERIC(18, 2) AS mediana_preco_Loja_sku,
        A.preco_medio AS preco_medio_Loja_sku,
		A.Preco_minimo	AS preco_minimo_Loja_sku
    FROM
        {{ref('temp_mediana')}} A
    GROUP BY
        A.cnpj_loja,
        A.Sku,
        A.id_linha,
        A.id_similar,
        A.segmentos,
        A.categoria,
        A.subcategoria,
        A.preco_medio,
		A.Preco_minimo,
        A.Cont