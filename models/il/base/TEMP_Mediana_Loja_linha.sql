SELECT
        A.cnpj_loja,
        A.id_linha,
        A.Cont,
        Sum(A.tkt_item) AS tkt_Loja_linha,
        Sum(A.fat_item) AS fat_loja_linha,
        Sum(A.qtd_item) AS qtd_loja_linha,
        SUM(A.MEDIANA * A.Preco) :: NUMERIC(18, 2) AS mediana_preco_loja_linha,
        A.preco_medio AS preco_medio_loja_linha,
		A.Preco_minimo	AS preco_minimo_Loja_linha
    FROM
       dev.TEMP_MEDIANA_linha A
    GROUP BY
        A.cnpj_loja,
        A.id_linha,
        A.preco_medio,
		A.Preco_minimo,
        A.Cont