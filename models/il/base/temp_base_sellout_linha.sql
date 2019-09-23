{{ config(schema="{{var('schema')}}") }}
SELECT
    A.cnpj_loja,
    A.id_linha,
    A."data",
    A.tkt_item,
    A.fat_item,
    A.Qtd_item,
    ((A.fat_item) /(A.Qtd_item)) :: numeric(18, 2) AS Preco,
    RANK() OVER ( PARTITION BY A.id_linha, A.cnpj_loja ORDER BY  Preco,   A."Data" )  AS Ordem
FROM
    {{ref('temp_base_sellout')}} A
WHERE
    TRUE
    AND A.id_linha is not null 
    AND A.id_linha <> ' '