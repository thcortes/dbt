{{ config(materialized='table') }}

SELECT
    vpld.cnpj_loja,
    vpld.sku_isnumeric as sku,
    vpld.flag_sku_valido,
    cps.id_linha,
    ids.id_Similar,
    cps.id_Produto_Padrao,
    cps.segmentos,
    cps.categoria,
    cps.subcategoria,
    vpld."data",
    SUM(vpld.quantidade_cupom) :: numeric(18, 2) AS tkt_item,
    SUM(vpld.valor_sellout) :: numeric(18, 2) AS fat_item,
    SUM(vpld.quantidade_sellout) :: numeric(18, 2) AS Qtd_item,
    vpld.data_hora_ingestao_dw
FROM
   	dev.il_venda_produto_loja_dia_u90d vpld	
    LEFT JOIN dev.dl_cadu_cadastro_produto cps on vpld.sku = cps.sku and cps.sku <> ''
    LEFT JOIN dev.temp_il_id_similar_sku ids ON  vpld.sku = ids.sku
WHERE
    TRUE
    AND (vpld.quantidade_sellout :: numeric(18, 2)) >= 0.01
    AND vpld.valor_sellout > 0
    AND vpld.quantidade_sellout > 0
    AND vpld.cnpj_loja IN ('04028538000165','18130858000136','24136358000104','28695623000145','23419280000253','18300489000182','25301413000137','30921369000106','10430266000128',
'00219359000154','29612698000188','11508142000180','14667450000147','01409086000173','13800124000101','16714499000139','30618719000151','05892738000124','03516892000176','19317950000172',
'01069698000164','30259625000133','30184108000142','20712375000191','13075175000100','32552449000159','16839471000128','03483801000143','62828462000159','01426668000168','26168727000176',
'21052289000162','04940360000124','23438193000162','31575885000180','27567202000176','23027503000156','33113210000145','04218923000175','11694605000146','10510533000177','28111385000183')
GROUP BY
    vpld.cnpj_loja,
    vpld.sku_isnumeric,
    vpld.flag_sku_valido,
    cps.id_linha,
    ids.id_Similar,
    cps.id_Produto_Padrao,
    cps.segmentos,
    cps.categoria,
    cps.subcategoria,
    vpld."data",
    vpld.data_hora_ingestao_dw;
