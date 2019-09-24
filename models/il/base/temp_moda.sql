{{ config(schema=target.name) }}

SELECT
        A.cnpj_loja,
        A.Sku,
        A.id_linha,
        A.id_similar,
        A.Preco_medio as preco_moda_loja_sku,
        B.Preco_medio as preco_moda_loja_linha,
        C.Preco_medio as preco_moda_loja_similar
    FROM 
        {{ref(var('temp_moda_sku'))}} A
    LEFT JOIN {{ref(var('temp_moda_linha'))}} B
    	ON A.id_linha = B.id_linha
    	AND A.cnpj_loja = B.cnpj_loja
    	AND B.Ordem_moda = 1
    LEFT JOIN {{ref(var('temp_moda_similar'))}} C
    	ON A.id_similar = C.id_similar
    	AND A.cnpj_loja = C.cnpj_loja
    	AND C.Ordem_moda = 1
    WHERE TRUE
    	AND A.Ordem_moda = 1    	