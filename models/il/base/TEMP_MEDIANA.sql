SELECT
        A.cnpj_loja,
        A.sku,
        A.id_linha,
        A.id_similar,
        A.segmentos,
        A.categoria,
        A.subcategoria,
        A.preco,
        A.tkt_item,
        A.fat_item,
        A.qtd_item,
        B.Preco_medio,							
		B.Preco_minimo,
        B.Cont,
        A.Ordem,
        CASE WHEN MOD(B.Cont, 2) = 1 THEN CASE WHEN (B.Cont + 1) / 2 = A.ORDEM THEN 1 ELSE 0 END ELSE CASE WHEN ((B.Cont) / 2 = A.ORDEM)
        or (((B.Cont) / 2) + 1 = A.ORDEM) THEN 0.5 ELSE 0 END END AS MEDIANA
    FROM
        dev.temp_Base_Sellout2 A
        LEFT JOIN dev.temp_Cont_Mediana B ON A.Cnpj_loja = B.Cnpj_loja
        and A.sku = B.sku