{{ config(schema="{{var('schema')}}") }}

SELECT
    sell.sku,
    CASE WHEN sell.sku ~ '^[0-9\]+$' THEN CAST(CAST(sell.sku AS numeric(23, 0)) AS VARCHAR(256)) ELSE sell.sku END sku_isnumeric,
    sell.cnpj_loja,
    sell.data_hora_lancamento :: Date as data,
    count(distinct sell.id_transacao) as quantidade_cupom,
    sum(cast(sell.total_item as numeric(18,2))) as valor_Sellout,
    sum(cast(sell.quantidade as numeric(18,2))) as quantidade_sellout,
    getdate() as data_hora_ingestao_dw
FROM
    dl_datalake_sellout sell -- left join {bu_schema}dl_cadastro_loja cad
    -- 	on  cad.id_loja = sell.id_loja
where
    data_hora_lancamento :: DATE >= (
        SELECT
            CURRENT_DATE - data_limite
        FROM
            dl_data_limite
    ) -- and cad.id_segmento ='1'
Group by
    sell.sku,
    CASE WHEN sell.sku ~ '^[0-9\]+$' THEN CAST(CAST(sell.sku AS numeric(23, 0)) AS VARCHAR(256)) ELSE sell.sku END,
    sell.cnpj_loja,
    sell.data_hora_lancamento :: Date