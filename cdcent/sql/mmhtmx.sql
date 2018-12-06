SELECT 
 SUBSTR(D.NAMEALL,INSTR(D.NAMEALL,'-',1,1)+1,INSTR(D.NAMEALL,'-',1,2)-INSTR(D.NAMEALL,'-',1,1)-1) AS 片区,
 D.NAME AS 签约店,
 U.USERNAME AS 签约人,
 T.CONTRACT_CODE AS 系统编号,
 T.HANDWRITING_CODE AS 手写编号, 
 T.IF_LIMIT AS 业务类型, 
 T.DEAL_DATE AS 成交日期, 
 T.REVIEW_DATE AS 审核日期, 
 MMFY.CODE AS 房源编号, 
 DUTY.NAME AS 房源店, 
 DUTY.USERNAME AS 房源人, 
 T.ADDRESS AS 房屋地址, 
 MMFY.BUILD_AREA AS 房屋面积, 
 P.NAME AS 业主, 
 PP.NAME AS 客户, 
 T.DEAL_PRICE AS 成交价, 
 R.RECEIVABLE AS 买方中介费, 
 SUM( R.RECEIVABLE) /T.DEAL_PRICE  AS 收费比例,
NVL(zjfwf.zjfwf,0) as 实收中介费,
NVL(mfzjf.mfzjf,0) as 卖方中介费,
NVL(pgfsr.pgfsr,0) as 评估费收入,
NVL(dkfwf.dkfwf,0) as 贷款服务费,
NVL(dzfwf.dzfwf,0) as 垫资服务费,
NVL(dbghf.dbghf,0) as 代办过户费,
NVL(qtfy.qtfy,0) as 其他费用,
NVL(zjfwf.zjfwf,0)+NVL(mfzjf.mfzjf,0)+NVL(pgfsr.pgfsr,0)+NVL(dkfwf.dkfwf,0)+NVL(dzfwf.dzfwf,0)+NVL(dbghf.dbghf,0)+NVL(qtfy.qtfy,0) AS 总结利,
NVL(dspgf.dspgf,0) as 代收评估费,
NVL(dksxf.dksxf,0) as 贷款手续费,
NVL(dsfk.dsfk,0) as 代收房款,
NVL(dsdj.dsdj,0) as 代收定金,
NVL(qtdsk.qtdsk,0) as 其他代收项,
T.STATUS AS 合同状态
FROM   BIZ_MM_CONTRACT T
JOIN (SELECT MC1.ID,SU.USERNAME,SD.NAME FROM BIZ_MM_CONTRACT MC1 JOIN BIZ_MMFY FY ON MC1.FY_ID = FY.ID JOIN SYS_USER SU ON SU.ID = FY.DUTY_USER_ID JOIN SYS_DEPARTMENT SD ON SD.ID = SU.DEPT_ID  ) DUTY
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
LEFT   JOIN BIZ_CONTRACT_FEE F
ON     F.CONTRACT_ID = T.ID
AND    F.FEE_NAME = '中介服务费'
AND    F.IS_REC = 0
JOIN   SYS_USER U
ON     U.ID = T.DEAL_USER_ID --签约店应当关联deal字段，而不是input字段
JOIN   SYS_DEPARTMENT D
ON     D.ID = T.DEAL_DEPT_ID
JOIN   BIZ_MMFY MMFY
ON     MMFY.ID = T.FY_ID
left join (
select mc.id,sum(nd.price) zjfwf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '中介服务费'
group by  mc.id
order by mc.id
) zjfwf
on zjfwf.id = t.id
left join (
select mc.id,sum(nd.price) mfzjf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '卖方中介费'
group by  mc.id
order by mc.id
) mfzjf
on mfzjf.id = t.id
left join (
select mc.id,sum(nd.price) pgfsr from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '评估费收入'
group by mc.id 
order by mc.id
) pgfsr
on pgfsr.id = t.id
left join (
select mc.id,sum(nd.price) dkfwf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '贷款服务费'
group by mc.id
order by mc.id
) dkfwf
on dkfwf.id = t.id
left join (
select mc.id,sum(nd.price) dzfwf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '垫资服务费'
group by mc.id
order by mc.id
) dzfwf
on dzfwf.id = t.id
left join (
select mc.id,sum(nd.price) dbghf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '代办过户费'
group by mc.id
order by mc.id
) dbghf
on dbghf.id = t.id
left join(
select mc.id,sum(nd.price) qtfy from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
join new_fin_profit_detail nd
on nd.fee_id = fee.id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0 and nd.is_rec = 0
and fee.fee_name = '其他费用'
group by mc.id
order by mc.id
) qtfy
on qtfy.id = t.id
left join (
select mc.id,sum(fee.price) dspgf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0
and fee.fee_name = '代收评估费'
group by mc.id
) dspgf
on dspgf.id = t.id
left join (
select mc.id,sum(fee.price) dksxf from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0
and fee.fee_name = '贷款手续费'
group by mc.id
) dksxf
on dksxf.id = t.id
left join (
select mc.id,sum(fee.price) dsfk from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0
and fee.fee_name = '代收房款'
group by mc.id
) dsfk
on dsfk.id = t.id
left join (
select mc.id,sum(fee.price) dsdj from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0
and fee.fee_name = '代收定金'
group by mc.id
) dsdj
on dsdj.id = t.id
left join (
select mc.id,sum(fee.price) qtdsk from biz_mm_contract mc
join biz_contract_fee fee
on mc.id = fee.contract_id
where mc.status = '已审核'
and mc.is_rec = 0 and fee.is_rec = 0
and fee.fee_name = '其他代收款'
group by mc.id
) qtdsk
on qtdsk.id = t.id
WHERE  T.STATUS != '失效'
AND    T.IS_REC = 0
AND    TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') >= TO_DATE('${MONTH_START}','yyyy-MM-dd')
AND    TO_DATE(to_char(T.REVIEW_DATE,'yyyy-MM-dd'),'yyyy-MM-dd') <= TO_DATE('${MONTH_END}','yyyy-MM-dd')
GROUP BY D.NAMEALL, D.NAME, U.USERNAME, T.CONTRACT_CODE, T.HANDWRITING_CODE,  T.IF_LIMIT,  T.DEAL_DATE,  T.REVIEW_DATE,  MMFY.CODE,  DUTY.NAME,  DUTY.USERNAME,  T.ADDRESS,  MMFY.BUILD_AREA, 
 P.NAME,  PP.NAME, T.DEAL_PRICE, R.RECEIVABLE, T.STATUS,zjfwf.zjfwf,mfzjf.mfzjf,pgfsr.pgfsr,dkfwf.dkfwf,dzfwf.dzfwf,dbghf.dbghf,qtfy.qtfy,dspgf.dspgf, dksxf.dksxf,dsfk.dsfk,dsdj.dsdj,qtdsk.qtdsk