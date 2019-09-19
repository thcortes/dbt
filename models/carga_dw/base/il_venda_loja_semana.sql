{{ config(schema="{{var('schema')}}") }}

WITH
    U12S
    AS
    (
        SELECT
            DISTINCT CAL.ANO454,
            CAL.SEMANA454 :: INT,
            CAL.PRIMEIRO_DIA_SEMANA,
            CAL.ULTIMO_DIA_SEMANA
        FROM
            {{ref('il_venda_loja_dia')}} AS DL
            JOIN dl_cadastro_calendario  cal on 1 = 1
            and dl.data :: date = cal.data
        WHERE
            1 = 1
            AND dl.data BETWEEN (
                Select
                DATE_TRUNC('week', max(data)) -(7 * 12)
            FROM
                {{ref('il_venda_loja_dia')}} dl
            )
            AND (
                SELECT
                MAX(dl.data)
            FROM
                {{ref('il_venda_loja_dia')}} dl
            )
            AND dl.data <= (
                Select
                date_trunc('week', max(data))
            FROM
                {{ref('il_venda_loja_dia')}} dl
            )
        ORDER BY
            cal.ano,
            cal.semana454
    ),
    U12S_PS
    AS
    (
        SELECT
            ANO454,
            SEMANA454 :: INT,
            RANK() OVER (
                ORDER BY
                    ANO454,
                    SEMANA454 ASC
            )
     :: INT AS LIST_U12S
        FROM
            U12S
    )
SELECT
    vd.cnpj_loja,
    dc.ano454 as ano454,
    dc.semana454 as semana,
    sum(vd.quantidade_cupom) as quantidade_cupom,
    sum(vd.quantidade_sku) as quantidade_sku,
    sum(vd.valor_sellout) as valor_sellout,
    sum(vd.quantidade_sellout) as quantidade_sellout
    , getdate() as data_hora_ingestao_dw
FROM
    {{ref('il_venda_loja_dia')}} AS vd --  LEFT JOIN DL_CADASTRO_LOJA  LOJ     ON LOJ.ID_LOJA = vd.ID_LOJA
    JOIN dl_cadastro_calendario dc ON vd.data :: date = dc.data
    JOIN U12S_PS U12 ON U12.SEMANA454 :: INT = dc.SEMANA454 :: INT --AND U12.ANO454 = CAL.ANO454
WHERE 
    1 = 1
        AND vd.data BETWEEN (
        Select
            date_trunc('week', MAX(vd.data) - (7 * 12))
        FROM
            {{ref('il_venda_loja_dia')}} vd
    )
    AND (
        SELECT
            MAX(vd.data)
        FROM
            {{ref('il_venda_loja_dia')}} vd
    )
        AND vd.data <= (
        Select
            date_trunc('week', MAX(vd.data))
        FROM
            {{ref('il_venda_loja_dia')}} vd
    )
--  AND LOJ.ID_Segmento = '1'
GROUP BY
    vd.cnpj_loja,
    dc.ano454,
    dc.semana454