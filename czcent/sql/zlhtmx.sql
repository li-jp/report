SELECT SUBSTR(D.NAMEALL,INSTR(D.NAMEALL,'-',1,1)+1,INSTR(D.NAMEALL,'-',1,2)-INSTR(D.NAMEALL,'-',1,1)-1) AS 片区,
 D.NAME AS 签约店,
 U.USERNAME AS 签约人,
 T.CONTRACT_CODE AS 系统编号,
 T.HANDWRITING_CODE AS 手写编号, 
 T.DEAL_DATE AS 成交日期, 
 T.REVIEW_DATE AS 审核日期, 
 ZLFY.CODE AS 房源编号, 
 DUTY.NAME AS 房源店, 
 DUTY.USERNAME AS 房源人, 
 T.ADDRESS AS 房屋地址, 
 ZLFY.BUILD_AREA AS 房屋面积, 
 P.NAME AS 业主, 
 PP.NAME AS 客户, 
 NVL(T.PRICE,0) AS 租价, 
 CONCAT('元/月 ',T.PAY_TYPE) AS 付款方式,
 NVL(R.RECEIVABLE,0) AS 应收中介费, 
 NVL(R1.RECEIVABLE,0) AS 卖方中介费, 

 SUM(R.RECEIVABLE + R1.RECEIVABLE) /T.PRICE AS 收费比例,
  NVL(zjfwf.zjfwf,0) AS 实收中介费,
  NVL(mfzjf.mfzjf,0) AS 卖方中介费,
 (NVL(zjfwf.zjfwf,0)+NVL(mfzjf.mfzjf,0)) AS 总结利,
 T.STATUS AS 合同状态
FROM   BIZ_ZL_CONTRACT T
JOIN (SELECT ZC.ID,SU.USERNAME,SD.NAME FROM BIZ_ZL_CONTRACT ZC LEFT JOIN BIZ_ZLFY FY ON ZC.FY_ID = FY.ID LEFT JOIN SYS_USER SU ON SU.ID = ZC.DUTY_USER_ID LEFT JOIN SYS_DEPARTMENT SD ON SD.ID = SU.DEPT_ID ) DUTY
 ON DUTY.ID = T.ID
JOIN   BIZ_CONTRACT_PERSON P
ON     P.CONTRACT_ID = T.ID
AND    P.TYPE = '业主'
AND    P.IS_REC = 0
JOIN   BIZ_CONTRACT_PERSON PP
ON     PP.CONTRACT_ID = T.ID
AND    PP.TYPE = '客户'
AND    PP.IS_REC = 0
JOIN   BIZ_CONTRACT_RECEIVABLE R
ON     R.CONTRACT_ID = T.ID
AND    R.FEE_TYPE = '中介服务费'
AND    R.IS_REC = 0
JOIN   BIZ_CONTRACT_RECEIVABLE R1
ON     R1.CONTRACT_ID = T.ID
AND    R1.FEE_TYPE = '卖方中介费'
AND    R1.IS_REC = 0
LEFT   JOIN BIZ_CONTRACT_FEE F
ON     F.CONTRACT_ID = T.ID
AND    F.FEE_NAME = '中介服务费'
AND    F.IS_REC = 0
JOIN   SYS_USER U
ON     U.ID = T.DEAL_USER_ID --签约店应当关联deal字段，而不是input字段
JOIN   SYS_DEPARTMENT D
ON     D.ID = T.DEAL_DEPT_ID
JOIN   BIZ_ZLFY ZLFY
ON     ZLFY.ID = T.FY_ID
left join (
select mc.id,sum(nd.price) zjfwf from biz_ZL_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where  mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0 and (fee.status = '已分成' or fee.status = '已审核') --存在于new_fin_profit_detail中的数据为收入类数据，流程状态为待确认-待审核-已审核-已分成
and fee.fee_name = '中介服务费'
group by  mc.id
order by mc.id
) zjfwf
on zjfwf.id = t.id
left join (
select mc.id,sum(nd.price) mfzjf from biz_ZL_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where  mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0 and (fee.status = '已分成' or fee.status = '已审核') --存在于new_fin_profit_detail中的数据为收入类数据，流程状态为待确认-待审核-已审核-已分成
and fee.fee_name = '卖方中介费'
group by  mc.id
order by mc.id
) mfzjf
on mfzjf.id = t.id
WHERE T.STATUS != '失效'
AND T.IS_REC = 0
AND   TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') >= TO_DATE('${MONTH_START}','yyyy-MM-dd')
AND   TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') <= TO_DATE('${MONTH_END}','yyyy-MM-dd')
GROUP BY D.NAMEALL, D.NAME, U.USERNAME, T.CONTRACT_CODE, T.HANDWRITING_CODE,  T.DEAL_DATE,  T.REVIEW_DATE,  ZLFY.CODE,  DUTY.NAME, DUTY.USERNAME, D.NAME,  U.USERNAME,  T.ADDRESS,  ZLFY.BUILD_AREA,  P.NAME,  PP.NAME,T.PRICE, T.PAY_TYPE, R.RECEIVABLE, R1.RECEIVABLE, zjfwf.zjfwf, mfzjf.mfzjf, T.PRICE,T.STATUS