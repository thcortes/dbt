{{ config(schema=target.name) }}

SELECT
        A.cnpj_loja,
        A.id_similar,
        A.Cont,
        Sum(A.tkt_item) AS tkt_Loja_similar,
        Sum(A.fat_item) AS fat_loja_similar,
        Sum(A.qtd_item) AS qtd_loja_similar,
        SUM(A.MEDIANA * A.Preco) :: NUMERIC(18, 2) AS mediana_preco_loja_similar,
        A.preco_medio AS preco_medio_loja_similar,
		A.Preco_minimo	AS preco_minimo_Loja_similar
    FROM
        {{ref('temp_mediana_similar')}} A
    GROUP BY
        A.cnpj_loja,
        A.id_similar,
        A.preco_medio,
		A.Preco_minimo,
        A.Cont