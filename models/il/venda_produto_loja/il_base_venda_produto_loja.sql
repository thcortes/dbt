-- config(alias="{{var('table_name')}}-table", schema="{{var('table_name')}}") }}


SELECT
    A.cnpj_loja,
    A.id_linha,
    A.id_similar,
    A.Sku,
    A.segmentos,
    A.categoria,
    A.subcategoria,
    A.tkt_Loja_sku,
    A.fat_Loja_sku,
    A.qtd_Loja_sku,
    A.mediana_preco_Loja_sku,
    A.preco_medio_Loja_sku,
	A.preco_minimo_Loja_sku,
    d.venda_media_diaria_loja_sku_u30d,
    B.tkt_loja_linha,
    B.fat_loja_linha,
    B.qtd_loja_linha,
    B.mediana_preco_loja_linha,
    B.preco_medio_loja_linha,
    B.preco_minimo_loja_linha,
    C.tkt_loja_similar,
    C.fat_loja_similar,
    C.qtd_loja_similar,
    C.mediana_preco_loja_similar,
    C.preco_medio_loja_similar,
    C.preco_minimo_loja_similar,
    E.Avg_tkt_Loja_subcat,
    E.Avg_fat_Loja_subcat,
    E.Avg_qtd_Loja_subcat,
    F.Avg_tkt_Loja_categoria,
    F.Avg_fat_Loja_categoria,
    F.Avg_qtd_Loja_categoria,
    G.Avg_tkt_Loja_segmento,
    G.Avg_fat_Loja_segmento,
    G.Avg_qtd_Loja_segmento,
    H.preco_moda_loja_sku,
    H.preco_moda_loja_linha,
    H.preco_moda_loja_similar,
    dateadd('hour',-3,getdate()) AS data_hora_ingestao_dw
FROM
    {{ref('temp_mediana_loja_sku')}} A
    LEFT JOIN {{ref('temp_mediana_loja_linha')}} B ON A.Cnpj_loja = B.Cnpj_loja
    and A.id_linha = B.id_linha
    LEFT JOIN {{ref('temp_mediana_loja_similar')}} C ON A.Cnpj_loja = C.Cnpj_loja
    AND A.id_similar = C.id_similar
    LEFT JOIN {{ref('temp_venda_media_diaria_u30d')}} D ON A.Cnpj_loja = D.Cnpj_loja
    AND A.sku = d.sku
    LEFT JOIN {{ref('temp_subcat')}} E ON A.Cnpj_loja = E.Cnpj_loja
    AND A.segmentos = E.segmentos
    AND A.categoria = E.categoria
    AND A.subcategoria = E.subcategoria
    LEFT JOIN {{ref('temp_categoria')}} F ON A.Cnpj_loja = F.Cnpj_loja
    AND A.segmentos = F.segmentos
    AND A.categoria = F.categoria
    LEFT JOIN {{ref('temp_segmentos')}} G ON A.Cnpj_loja = G.Cnpj_loja
    AND A.segmentos = G.segmentos
    LEFT JOIN {{ref('temp_moda')}} H ON A.Cnpj_loja = H.Cnpj_loja
    and A.sku = H.sku
WHERE 
    A.sku NOT LIKE 'table_name'