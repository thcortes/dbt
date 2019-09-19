{{ config(schema="{{var('schema')}}") }}

SELECT
    ds.data_hora_lancamento :: DATE as data,
    count(DISTINCT ds.id_transacao) as quantidade_cupom,
    count(DISTINCT ds.SKU),
    sum(cast(ds.total_item as numeric(18,2))),
    sum(cast(ds.quantidade as numeric(18,2))),
    ds.cnpj_loja,
    getdate() as data_hora_ingestao_dw
from
    dl_datalake_sellout as ds -- LEFT JOIN {bu_schema}dl_cadastro_loja as CL
    -- ON CL.ID_LOJA = ds.id_loja
WHERE
    1 = 1
    AND ds.data_hora_lancamento :: date >= (
        SELECT
            CURRENT_DATE - data_limite
        FROM
            dl_data_limite
    ) --AND ds.data_hora_lancamento::date BETWEEN '2019-01-01' AND '2019-01-23'
    -- AND CL.ID_SEGMENTO ='1'
GROUP BY
    ds.cnpj_loja,
    ds.data_hora_lancamento :: DATE