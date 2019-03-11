SELECT SUBSTR(D.NAMEALL,INSTR(D.NAMEALL,'-',1,1)+1,INSTR(D.NAMEALL,'-',1,2)-INSTR(D.NAMEALL,'-',1,1)-1) AS 片区,
 D.NAME AS 签约店,
 U.USERNAME AS 签约人,
 T.CONTRACT_CODE AS 系统编号,
 T.HANDWRITING_CODE AS 手写编号, 
 T.DEAL_DATE AS 成交日期, 
 T.REVIEW_DATE AS 审核日期, 
 DLFY.CODE AS 项目编号, 
 DLFY.ADDRESS AS 项目地址, 
 DLFY.STATUS AS 项目状态,
 DLFY.NAME AS 项目名称,
 T.BUILD_AREA AS 房屋面积, 
 P.NAME AS 业主, 
 PP.NAME AS 客户, 
 T.KY_ID AS 客源ID,
 NVL(T.DEAL_PRICE,0) AS 成交价, 
 NVL(R.RECEIVABLE,0) AS 应收中介费, 
 NVL(zjfwf.zjfwf,0) AS 实收中介费,
 T.STATUS AS 合同状态
FROM   BIZ_BUILDING_CONTRACT T
LEFT JOIN   BIZ_CONTRACT_PERSON P
ON     P.CONTRACT_ID = T.ID
AND    P.TYPE = '业主'
AND    P.IS_REC = 0
LEFT JOIN   BIZ_CONTRACT_PERSON PP
ON     PP.CONTRACT_ID = T.ID
AND    PP.TYPE = '客户'
AND    PP.IS_REC = 0
JOIN   BIZ_CONTRACT_RECEIVABLE R
ON     R.CONTRACT_ID = T.ID
AND    R.FEE_TYPE = '中介服务费'
AND    R.IS_REC = 0
LEFT   JOIN BIZ_CONTRACT_FEE F
ON     F.CONTRACT_ID = T.ID
AND    F.FEE_NAME = '中介服务费'
AND    F.IS_REC = 0
JOIN   SYS_USER U
ON     U.ID = T.DEAL_USER_ID --签约店应当关联deal字段，而不是input字段
JOIN   SYS_DEPARTMENT D
ON     D.ID = T.DEAL_DEPT_ID
JOIN   BIZ_BUILDING DLFY
ON     DLFY.ID = T.BUILDING_ID
left join (
select mc.id,sum(nd.price) zjfwf from biz_BUILDING_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where  mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0 and (fee.status = '已审核' or fee.status = '已分成') --存在于new_fin_profit_detail中的数据为收入类数据，流程状态为待确认-待审核-已审核-已分成
and fee.fee_name = '中介服务费'
group by  mc.id
order by mc.id
) zjfwf
on zjfwf.id = t.id
WHERE T.STATUS != '失效'
AND T.IS_REC = 0
AND   TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') >= TO_DATE('${MONTH_START}','yyyy-MM-dd')
AND   TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') <= TO_DATE('${MONTH_END}','yyyy-MM-dd')
GROUP BY D.NAMEALL, D.NAME, U.USERNAME, T.CONTRACT_CODE, T.HANDWRITING_CODE,  T.DEAL_DATE,  T.REVIEW_DATE,  DLFY.CODE, D.NAME,  U.USERNAME,  DLFY.ADDRESS,  T.BUILD_AREA,  P.NAME,  PP.NAME, R.RECEIVABLE, zjfwf.zjfwf, T.DEAL_PRICE,DLFY.STATUS, DLFY.NAME,  T.KY_ID, T.STATUS
ORDER BY D.NAMEALL, D.NAME, U.USERNAME